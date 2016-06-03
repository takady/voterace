class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  helper_method :current_user, :signed_in?

  private

  def current_user
    return unless session[:user_id]

    User.find_by!(id: session[:user_id])
  end

  def set_current_user
    @user = current_user
  end

  def signed_in?
    session[:user_id].present?
  end

  def authenticate
    return if signed_in?

    redirect_to signin_path
  end
end
