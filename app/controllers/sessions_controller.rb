class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    session_params = params[:session]
    email_param = session_params[:email].downcase
    user = User.find_by(email: email_param)

    if user 
      password_param = session_params[:password]
      if user.authenticate(password_param)
        # authenticated
        session[:user_id] = user.id
        flash[:notice] = "Welcome back #{user.username}!"
        redirect_to user
      else
        flash.now[:alert] = "Invalid password"
        render 'new', status: :unauthorized
      end
    else
      flash.now[:alert] = "Invalid login details"
      render 'new', status: :not_found
    end
  
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged out successfully."
    redirect_to login_path
  end
end