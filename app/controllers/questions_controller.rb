class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all

    render json: @questions and return
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    render json: @question and return
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.json { render :show, status: :created, location: @question }
      else
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :candidate_1, :candidate_2)
    end
end
