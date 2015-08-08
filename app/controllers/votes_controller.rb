class VotesController < ApplicationController
  before_action :set_vote, only: :update

  def create
    @vote = Vote.new(vote_params)

    respond_to do |format|
      if @vote.save
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.json { render json: @vote, status: :ok, location: @vote }
      else
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:user_id, :question_id, :candidate)
    end
end
