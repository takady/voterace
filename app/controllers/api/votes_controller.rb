class Api::VotesController < Api::ApiController
  def create
    race = Race.votable.find_by(params[:race_id])

    current_user.vote_for(candidate)

    render json: Resource::Race.new(race, current_user: current_user).to_response
  end

  private

  def candidate
    Candidate.find_by!(race_id: params[:race_id], order: params[:candidate_order])
  end
end
