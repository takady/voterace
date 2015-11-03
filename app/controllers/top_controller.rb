class TopController < ApplicationController
  before_action :authenticate, except: :index

  def index
    if logged_in?
      @races = Race.all
      render 'races/index'
    end
  end
end
