class RacesController < ApplicationController
  before_action :authenticate, except: [:index, :show]

  def index
  end

  def show
  end
end
