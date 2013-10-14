class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  # protect_from_forgery with: :exception
  
  def authorized_user!
    unless user_logged_in?
      redirect_to root_path
    end
  end

  def user_logged_in?
    if current_user
      true
    else
      false
    end
  end
  
  helper_method :current_user

  private

    def current_user
      @current_user ||= User.find(session[:facebook_uid]) if session[:facebook_uid]
    end
  
end
