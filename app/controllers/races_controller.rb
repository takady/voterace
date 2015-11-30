class RacesController < ApplicationController
  before_action :set_race, only: [:show, :destroy]

  def index
    @races = Race.page(params[:page]).order(:id)
  end

  def show
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

  def vote
    Vote.find_or_initialize_by(race_id: vote_params[:race_id], user_id: current_user.id).update(candidate: vote_params[:candidate])

    redirect_to root_path, notice: 'Voted!'
  rescue e
    redirect_to root_path, alert: 'Vote Failed!'
  end

  private

  def set_race
    @race = Race.find(params[:id])
  end

  def race_params
    params.require(:race).permit(:title, :candidate_1, :candidate_2, :expired_at)
  end

  def vote_params
    params.require(:vote).permit(:race_id, :candidate)
  end
end
