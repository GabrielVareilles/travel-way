class FetchreviewsController < ApplicationController

  def index
    results = FetchReviewsService.new(params[:yelp_id]).()

    h_activities = []

    render json: results
  end

end
