class Api::RacesController < Api::ApiController
  before_action :authenticate, except: [:index, :show]
  before_action :set_race, only: [:show, :destroy]

  def index
    races = Race.votable.page(params[:page]).order('id DESC')

    render json: races.map {|race| Resource::Race.new(race, current_user: current_user).to_response }
  end

  def show
    render json: Resource::Race.new(@race, current_user: current_user).to_response
  end

  def create
    race = current_user.races.build_with_candidates(create_params)

    if race.save
      render json: Resource::Race.new(race, current_user: current_user).to_response, status: :created
    else
      render json: {validation_errors: race.errors}, status: :bad_request
    end
  end

  def destroy
    head :bad_request and return unless current_user.id == @race.user_id

    @race.destroy!

    head :ok
  end

  private

  def set_race
    @race = Race.find(params[:id])
  end

  def create_params
    params.permit(:title, :expired_at, candidates: [:name, :order])
  end
end
