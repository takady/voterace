class TopController < ApplicationController
  before_action :authenticate, except: :index

  def index
    if sign_in?
      @races = Race.order(:id).last(10)

      render 'races/index'
    end
  end
end
