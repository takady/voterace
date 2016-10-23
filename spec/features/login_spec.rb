require 'rails_helper'

feature 'Login', js: true do
  feature 'with Twitter' do
    background do
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
        provider: 'twitter', uid: '1', info: {nickname: 'test', image: 'http://example.com/test.png'}
      })

      visit signin_path
    end

    feature 'sign up' do
      scenario 'creates new user account' do
        expect {
          click_link 'Sign in with Twitter'
          fill_in 'Email', with: 'test@example.com'
          fill_in 'Password', with: 'test'
          fill_in 'Password Confirmation', with: 'test'
          click_button 'Sign up'
        }.to change(User, :count).by(1).and change(SocialProfile, :count).by(1)

        expect(page.current_path).to eq(root_path)
        expect(page).to have_content('You are successfully sign up!')
      end
    end

    feature 'sign in' do
      background 'exist a user with this social profile' do
        user = create(:user)
        create(:social_profile, provider: 'twitter', uid: '1', user: user)
      end

      scenario 'login with existing user account' do
        expect {
          click_link 'Sign in with Twitter'
        }.to change(User, :count).by(0).and change(SocialProfile, :count).by(0)

        expect(page.current_path).to eq(root_path)
      end
    end
  end

  feature 'with Facebook' do
    background do
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        provider: 'facebook', uid: '1', info: {name: 'test', image: 'http://example.com/test.png'}
      })

      visit signin_path
    end

    feature 'sign up' do
      scenario 'creates new user account' do
        expect {
          click_link 'Sign in with Facebook'
          fill_in 'Email', with: 'test@example.com'
          fill_in 'Password', with: 'test'
          fill_in 'Password Confirmation', with: 'test'
          click_button 'Sign up'
        }.to change(User, :count).by(1).and change(SocialProfile, :count).by(1)

        expect(page.current_path).to eq(root_path)
        expect(page).to have_content('You are successfully sign up!')
      end
    end

    feature 'sign in' do
      background 'exist a user with this social profile' do
        user = create(:user)
        create(:social_profile, provider: 'facebook', uid: '1', user: user)
      end

      scenario 'login with existing user account' do
        expect {
          click_link 'Sign in with Facebook'
        }.to change(User, :count).by(0).and change(SocialProfile, :count).by(0)

        expect(page.current_path).to eq(root_path)
      end
    end
  end
end
