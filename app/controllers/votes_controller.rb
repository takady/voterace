class VotesController < ApplicationController
  before_action :authenticate
  before_action :set_race

  def create
    flash[:alert] = 'Vote failed! This race has already been expired.' unless @race.votable?

    current_user.vote_for(candidate)

    redirect_to request.referer
  end

  private

  def set_race
    @race = Race.find(params[:race_id])
  end

  def candidate
    Candidate.find_by!(race_id: params[:race_id], order: params[:candidate_order])
  end
end
