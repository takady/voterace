class Api::RacesController < Api::ApiController
  before_action :authenticate, except: [:index, :show]
  before_action :set_race, only: [:show, :destroy]

  def index
    # TODO make it possible to fetch by cursor
    races = Race.votable.order('id DESC').first(30)

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
      render json: race.errors.messages, status: :bad_request
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
    params.permit(:title, :expired_at, candidates: [])
  end
end
