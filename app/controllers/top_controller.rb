class TopController < ApplicationController
  before_action :authenticate, except: :index

  def index
    if sign_in?
      @races = Race.page(params[:page]).order(:id)

      render 'races/index'
    end
  end
end
