class RacesController < ApplicationController
  before_action :set_race, only: [:show, :destroy]

  def index
    @races = Race.all
  end

  def show
  end

  def new
    @race = Race.new
  end

  def create
    @race = Race.new(race_params)

    if @race.save
      redirect_to @race, notice: 'Race was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @race.destroy

    redirect_to races_url, notice: 'Race was successfully destroyed.'
  end

  def vote
    if %w(1 2).include?(vote_params[:candidate])
      vote = Vote.find_or_initialize_by(race_id: vote_params[:race_id].to_i, user_id: vote_params[:user_id].to_i)
      vote.update_attributes(candidate: vote_params[:candidate])
    end

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
