class RacesController < ApplicationController
  before_action :authenticate, except: :show
  before_action :set_race, only: [:show, :destroy, :vote]

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
    if @race.votable?
      if current_user.vote(race_id: @race.id, candidate: params[:candidate])
        flash[:notice] = 'Voted!'
      else
        flash[:alert] = 'Vote failed!'
      end
    else
      flash[:alert] = 'Vote failed! This race has already been expired.'
    end

    redirect_to root_path
  end

  private

  def set_race
    @race = Race.find(params[:id])
  end

  def race_params
    params.require(:race).permit(:title, :candidate_1, :candidate_2, :expired_at)
  end
end
