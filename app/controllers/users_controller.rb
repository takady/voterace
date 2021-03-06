class UsersController < ApplicationController
  before_action :authenticate, except: [:show, :new, :create]
  before_action :set_current_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find_by!(username: params[:username])
  end

  def new
    if auth = request.env['omniauth.auth']
      social_profile = SocialProfile.create_with(username: auth.info.nickname).find_or_create_by(provider: auth.provider, uid: auth.uid)

      if social_profile.user
        session[:user_id] = social_profile.user.id
        redirect_to root_path and return
      end

      session[:social_profile_id] = social_profile.id

      @user = User.new(username: auth.info.nickname || auth.info.name.remove(' ').downcase, email: auth.info.email, fullname: auth.info.name, description: auth.info.description, image_url: auth.info.image)
    else
      reset_session

      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      if social_profile = SocialProfile.find_by(id: session[:social_profile_id])
        social_profile.update(user: @user)
      end
      session[:user_id] = @user.id

      redirect_to root_path, notice: 'You are successfully sign up!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to :settings, notice: 'You are successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:username, :fullname, :email, :image_url, :description, :password, :password_confirmation)
  end
end
