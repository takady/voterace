module Api
  class VotesController < ApplicationController
    before_action :set_vote, only: :update

    def create
      @vote = Vote.new(vote_params)

      if @vote.save
        render json: @vote, status: :created
      else
        render json: @vote.errors, status: :unprocessable_entity
      end

    end

    def update
      if @vote.update(vote_params)
        render json: @vote, status: :ok
      else
        render json: @vote.errors, status: :unprocessable_entity
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :race_id, :candidate)
    end
  end
end
