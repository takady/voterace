class UsersController < ApplicationController
  before_action :current_user

  def show
  end

  def edit
  end

  def update
    if @current_user.update(user_params)
      redirect_to @current_user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @current_user.destroy

    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
