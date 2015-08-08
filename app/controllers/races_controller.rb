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

    respond_to do |format|
      if @race.save
        format.html { redirect_to @race, notice: 'Race was successfully created.' }
        format.json { render :show, status: :created, location: @race }
      else
        format.html { render :new }
        format.json { render json: @race.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @race.destroy
    respond_to do |format|
      format.html { redirect_to races_url, notice: 'Race was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def vote
    if [1, 2].include?(vote_params[:candidate])
      vote = Vote.find_or_initialize_by(race: vote_params.race_id, user: vote_params.user_id)
      vote.update_attributes(candidate: vote_params.candidate)
    end

    respond_to do |format|
      format.html { redirect_to races_path, notice: 'Vote was successfully created.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_race
      @race = Race.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def race_params
      params.require(:race).permit(:title, :candidate_1, :candidate_2)
    end

    def vote_params
      params.require(:vote).permit(:race_id, :user_id, :candidate)
    end
end
