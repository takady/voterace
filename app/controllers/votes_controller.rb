class VotesController < ApplicationController
  before_action :authenticate
  before_action :set_race

  def create
    flash[:alert] = 'Vote failed! This race has already been expired.' unless @race.votable?

    unless current_user.vote_for(race_id: @race.id, candidate_order: params[:candidate_order])
      flash[:alert] = 'Vote failed!'
    end

    redirect_to request.referer
  end

  private

  def set_race
    @race = Race.find(params[:race_id])
  end
end
