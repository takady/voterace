class SessionsController < ApplicationController
  before_action :authenticate, except: [:create, :destroy]

  def create
    user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to races_path
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'You have successfully logged out.'
  end
end
