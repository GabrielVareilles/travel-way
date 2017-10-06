class ActivitiesController < ApplicationController
  def index
    @places = params[:places]
  end

  def show
  end
end
