class Api::VotesController < Api::ApiController
  def create
    candidate = Candidate.find_by!(id: params[:candidate_id])

    head :bad_request and return unless candidate.votable?

    current_user.vote_for(candidate)

    render json: Resource::Race.new(candidate.race, current_user: current_user).to_response
  end
end
