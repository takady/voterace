class Api::ApiController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :authenticate, except: [:render_404, :render_500]

  rescue_from StandardError, with: :render_500
  rescue_from ActionController::RoutingError, ActiveRecord::RecordNotFound, with: :render_404

  private

  def render_404
    head :not_found
  end

  def render_500(error = nil)
    if error
      Rails.logger.error(
        error_class: error.class,
        error_message: error.message,
        error_backtrace: error.backtrace
      )
    end

    head :internal_server_error
  end

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def authenticate
    return if current_user

    head :unauthorized and return
  end
end
