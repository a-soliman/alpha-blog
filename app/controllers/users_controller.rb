class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.paginate(page: params[:page]).order('created_at ASC')
  end
  
  def show
    @articles = @user.articles.paginate(page: params[:page]).order('created_at ASC')
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfuly signed up."
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'new', status: :bad_request
    end
  end

  def edit
    if @user != nil
      if !can_modify?(@user)
        flash[:alert] = "You can't access this user"
        redirect_to users_path
        return
      end
      render 'edit'
    else
      flash[:alert] = "User was not found"
      redirect_to root_path
    end
  end

  def update
    redirect_to users_path, status: :forbidden if !can_modify?(@user)
    
    if @user.update(user_params)
      flash[:notice] = "Account was updated successfully."
      redirect_to @user
    else
      render 'edit', status: :bad_request
    end
  end

  def destroy
    if @user != nil
      if !can_modify?(@user)
        flash[:alert] = "You can't access this user"
        redirect_to users_path
        return
      end
      
      # delere the user and articles
      @user.destroy
      session[:user_id] = nil if current_user == @user # to account for admins trying to remove another user
      flash[:notice] = "Account and all associated articles successfully deleted"
      redirect_to articles_path

    else
      flash[:alert] = "User was not found"
      redirect_to root_path
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :bio, :password)
  end
end