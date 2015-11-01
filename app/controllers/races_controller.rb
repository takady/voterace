class RacesController < ApplicationController
  before_action :set_race, only: [:show, :destroy]

  def index
    @races = Race.all
  end

  def show
  end

  def new
    @race = current_user.created_races.build
  end

  def create
    @race = current_user.created_races.build(race_params)

    if @race.save
      redirect_to @race, notice: 'Race was successfully created.'
    else
      render :new
    end
  end

  def destroy
    if current_user.id == @race.id
      @race.destroy
      redirect_to races_url, notice: 'Race was successfully destroyed.'
    else
      redirect_to races_url
    end
  end

  def vote
    Vote.find_or_initialize_by(race_id: vote_params[:race_id], user_id: current_user.id).update(candidate: vote_params[:candidate])

    flash[:notice] = 'Voted!'
    redirect_to races_path
  rescue e
    flash[:alert] = 'Vote Failed!'
    redirect_to races_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
      @vote_for_candidate_1 = Vote.where(race: @race.id).where(candidate: 1).count
      @vote_for_candidate_2 = Vote.where(race: @race.id).where(candidate: 2).count
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:title, :candidate_1, :candidate_2)
    end

    def vote_params
      params.require(:vote).permit(:race_id, :user_id, :candidate)
    end
end
