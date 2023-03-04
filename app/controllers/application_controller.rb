class ApplicationController < ActionController::Base

  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :logged_in?
  def logged_in?
    !!current_user
  end

  helper_method :can_modify?
  def can_modify?(object)
    return false if !logged_in?
    
    case object.class.name.downcase
    when "article"
      can_modify_article?(object)
    when "user"
      can_modify_user?(object)
    end
  end

  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end

  private
  def can_modify_user?(user)
    user == current_user
  end
  
  def can_modify_article?(article)
    article.user == current_user
  end
end
