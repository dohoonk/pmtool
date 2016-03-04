class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def current_user
    @current_user = User.find_by_id session[:user_id]
  end
  helper_method :current_user

  def authenticate!
    redirect_to new_session_path, notice: "Please Sign In" unless user_singed_in?
  end
end
