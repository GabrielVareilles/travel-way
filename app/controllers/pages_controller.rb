#require_relative '../services/fetch_rome2rio_service.rb'
require "open-uri"
require "nokogiri"


class PagesController < ApplicationController
  def home
  end

  def testapi
  end

  def setplaces
    @trip = Trip.new
  end

  def setactivities
    @trip = Trip.new(trip_params)
    @number_of_days = (params[:trip][:end_date].to_date - params[:trip][:start_date].to_date).to_i


    @places = params['trip']['places'].reject{ |p| p.empty? }.map do |place|
      { name: place, activities: [] }
    end

    # places.each do |place|
    #   ActivitiesCategories::CATEGORIES.flatten.each do |category|
    #       results = FetchActivitiesService.new(category, place[:name]).()
    #       results.map! do |activity|
    #         activity['category'] = category
    #         activity['yelp_id'] = activity['id']
    #         activity.delete('id')
    #         activity['latitude'] = activity['coordinates']['latitude']
    #         activity['longitude'] = activity['coordinates']['longitude']
    #         activity.delete('coordinates')
    #         activity['place_name'] = activity['location']['city']
    #         activity['display_address'] = activity['location']['display_address'].join(' ')
    #         activity.delete('location')
    #         activity
    #       end
    #
    #       place[:activities] += results
    #   end
    # end
    #
    # yelp_ids = []
    # Activity.bulk_insert(ignore: true) do |worker|
    #   @categories = places.each_with_object([]) do |place, o|
    #     o << place[:activities].map do |activity|
    #       worker.add(activity)
    #       yelp_ids << activity['yelp_id']
    #       activity['category']
    #     end
    #   end.first.uniq
    # end
    #
    # @places = Activity.where(yelp_id: yelp_ids).group_by { |a| a['place_name'] }
    # @trip = Trip.new
  end


  def profile
  end

  private




  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :activity_ids)
  end

end
