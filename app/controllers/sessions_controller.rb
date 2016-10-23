class SessionsController < ApplicationController
  before_action :authenticate, except: [:new, :create, :destroy]

  def new
  end

  def create
    unless user = find_user
      redirect_to signin_path, alert: 'Username or email can\'t be blank.'
      return
    end

    unless user.password_digest
      redirect_to signin_path, alert: 'You have not configure your password yet. Please sign in with sns account.'
      return
    end

    if user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect_to root_path, notice: 'You are successfully sign up!'
    else
      @identifier = params[:identifier]
      flash.now[:alert] = 'Wrong Username or Password!'

      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'You have successfully logged out.'
  end

  def find_user
    return if params[:identifier].blank?

    if params[:identifier].include?('@')
      User.find_by(email: params[:identifier])
    else
      User.find_by(username: params[:identifier])
    end
  end
end
