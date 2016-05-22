class TopController < ApplicationController
  before_action :authenticate, except: :index

  def index
    if signed_in?
      @races = Race.votable.page(params[:page]).order('id DESC')

      render 'races/index'
    end
  end
end
