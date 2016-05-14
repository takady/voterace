class RacesController < ApplicationController
  before_action :authenticate, except: :show
  before_action :set_race, only: [:show, :destroy, :vote]

  def index
    @races = Race.votable.page(params[:page]).order('id DESC')
  end

  def show
    @title = @race.title
  end

  def new
    @race = current_user.races.build
  end

  def create
    @race = current_user.races.build(race_params)

    if @race.save
      redirect_to @race, notice: 'Race was successfully created.'
    else
      render :new
    end
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

  def race_params
    params.require(:race).permit(:title, :candidate_1, :candidate_2, :expired_at)
  end
end
