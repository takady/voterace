class TopController < ApplicationController
  before_action :authenticate, except: :index

  def index
    @user = User.new
  end
end
