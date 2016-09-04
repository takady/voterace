class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate, except: [:render_404, :render_500]

  helper_method :current_user, :signed_in?

  rescue_from Exception, with: :render_500
  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :render_404

  def render_404
    render_error 404
  end

  def render_500(e = nil)
    render_error 500, e
  end

  private

  def render_error(status, e = nil)
    @error_message = e.message if e

    render template: "errors/#{status}.html", status: status, layout: 'application', content_type: 'text/html'
  end

  def current_user
    return unless session[:user_id]

    @current_user || User.find(session[:user_id])
  end

  def set_current_user
    @current_user = current_user
  end

  def signed_in?
    session[:user_id].present?
  end

  def authenticate
    return if signed_in?

    redirect_to login_path
  end
end
