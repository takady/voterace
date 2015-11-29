class SessionsController < ApplicationController
  before_action :authenticate, except: [:destroy]

  def destroy
    reset_session
    redirect_to root_path, notice: 'You have successfully logged out.'
  end
end
