class Api::RacesController < Api::ApiController
  before_action :authenticate, except: [:index, :show]
  before_action :set_race, only: [:show]

  def index
    races = Race.votable.page(params[:page]).order('id DESC')

    render json: races.map {|race| Resource::Race.new(race, current_user: current_user).to_response }
  end

  def show
    render json: Resource::Race.new(@race, current_user: current_user).to_response
  end
  private

  def set_race
    @race = Race.find(params[:id])
  end
end
