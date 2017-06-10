class RacesController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :set_race, only: [:destroy]

  def index
  end

  def show
    @id = params[:id]
    @title = Race.find(params[:id]).title
  end

  def destroy
    if current_user.id == @race.user_id
      @race.destroy
      redirect_to root_path, notice: 'Race was successfully destroyed.'
    else
      redirect_to root_path
    end
  end

  private

  def set_race
    @race = Race.find(params[:id])
  end
end
