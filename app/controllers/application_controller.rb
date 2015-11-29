class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate

  helper_method :current_user, :sign_in?

  private

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])

    if @current_user.nil?
      redirect_to root_path, alert: 'You are not singed in.'
    end

    @current_user
  end

  def sign_in?
    !!session[:user_id]
  end

  def authenticate
    return if sign_in?
    redirect_to root_path, alert: 'You are not singed in.'
  end
end
