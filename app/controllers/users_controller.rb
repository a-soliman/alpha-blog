class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username}, you have successfuly signed up."
      redirect_to articles_path
    else
      render 'new', status: :bad_request
    end
  end

  def edit
    if @user != nil
      render 'edit'
    else
      flash[:alert] = "User was not found"
      redirect_to home_path
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Account was updated successfully."
      redirect_to articles_path
    else
      render 'edit', status: :bad_request
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end