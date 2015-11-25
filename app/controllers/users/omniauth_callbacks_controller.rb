class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback
  end

  def twitter
    callback
  end

  private

  def callback
    auth = request.env['omniauth.auth']

    ActiveRecord::Base.transaction do
      social_profile = SocialProfile.create_with(username: auth.info.nickname).find_or_create_by!(provider: auth.provider, uid: auth.uid)

      if user = social_profile.user
        flash.notice = 'Successfully sign in!'

        sign_in_and_redirect user
      else
        session['devise.user_attributes'] = {username: auth.info.nickname, email: auth.info.email}

        redirect_to new_user_registration_path
      end
    end
  end
end
