class RacesController < ApplicationController
  before_action :authenticate, except: [:index, :show]
  before_action :set_race, only: [:show, :destroy]

  def index
    @race = build_race
  end

  def show
    @title = @race.title
  end

  def new
    @race = build_race
  end

  def create
    @race = current_user.races.build(race_params)

    if @race.save
      redirect_to @race, notice: 'Race was successfully created.'
    else
      (Candidate::ORDERS.to_a - @race.candidates.map(&:order)).each do |order|
        @race.candidates.build(order: order)
      end

      render :new
    end
  end

  def destroy
    if current_user.id == @race.user_id
      @race.destroy
      redirect_to root_path, notice: 'Race was successfully destroyed.'
    else
      redirect_to root_path
    end
  end

  private

  def set_race
    @race = Race.find(params[:id])
  end

  def build_race
    Race.new.tap {|race|
      Candidate::ORDERS.each do |order|
        race.candidates.build(order: order)
      end
    }
  end

  def race_params
    params.require(:race).permit(:title, :expired_at, candidates_attributes: [:name, :order])
  end
end
