module Api
  class RacesController < ApplicationController
    before_action :set_race, only: [:show, :destroy]

    def index
      @races = Race.all

      render json: @races and return
    end

    def show
      render json: @race and return
    end

    def create
      @race = Race.new(race_params)

      if @race.save
        render json: @race, status: :created
      else
        render json: @race.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @race.destroy
      head :no_content
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
  end
end