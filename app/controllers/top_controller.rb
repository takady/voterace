class TopController < ApplicationController
  def index
    if user_signed_in?
      @races = Race.all
      render 'races/index'
    end
  end
end
