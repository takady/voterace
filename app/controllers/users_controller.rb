class UsersController < ApplicationController
  before_action :authenticate, except: [:new, :create]
  before_action :current_user, except: [:new, :create]

  def mypage
  end

  def show
    @user = User.find(params[:id])
    @races = Race.where(user: @user)
  end

  def new
    if auth = request.env['omniauth.auth']
      social_profile = SocialProfile.create_with(username: auth.info.nickname).find_or_create_by(provider: auth.provider, uid: auth.uid)

      if current_user = social_profile.user
        session[:user_id] = current_user.id
        redirect_to root_path
      else
        session[:social_profile_id] = social_profile.id
        @current_user = User.new(username: auth.info.nickname || auth.info.name.remove(' ').downcase, email: auth.info.email, fullname: auth.info.name, description: auth.info.description, image_url: auth.info.image)
      end
    else
      reset_session

      @current_user = User.new
    end
  end

  def create
    @current_user = User.new(user_params)

    if @current_user.save
      if session[:social_profile_id]
        if social_profile = SocialProfile.find(session[:social_profile_id])
          social_profile.update(user: @current_user)
        end
      end
      session[:user_id] = @current_user.id

      redirect_to :mypage, notice: 'You are successfully sign up!'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @current_user.update(user_params)
      redirect_to :mypage, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @current_user.destroy

    redirect_to root_path, notice: 'User was successfully destroyed.'
  end

  private

  def user_params
    params.require(:user).permit(:username, :fullname, :email, :image_url, :description)
  end
end
