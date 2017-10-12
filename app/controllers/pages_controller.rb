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
    @places = []
    @trip = Trip.new(trip_params)
    @params = params
    params['trip']['places'].reject{ |c| c.empty? }.each do |place|
      @places << { name: place, activities: [] }
    end

    Activity.bulk_insert(ignore: true) do |worker|
    @places.each do |place|
      ActivitiesCategories::CATEGORIES.each do |category|
        category.each do |subcategory|
          results = FetchActivitiesService.new(subcategory, place[:name]).()
          #results.map! { |activity| activity.to_h }
          results.map! do |activity|
            activity['category'] = category[0]
            activity['yelp_id'] = activity['id']
            activity.delete('id')
            activity['latitude'] = activity['coordinates']['latitude']
            activity['longitude'] = activity['coordinates']['longitude']
            activity.delete('coordinates')
            activity['place_name'] = activity['location']['city']
            activity['display_address'] = activity['location']['display_address'].join(' ')
            activity.delete('location')
            activity
          end

          place[:activities].map! { |activity| activity.is_a?(Hash) ? activity : activity.attributes }
          place[:activities] << results.flatten
          place[:activities].flatten!
        end

        yelp_ids = []

          place[:activities].each do |activity|
            worker.add(activity)
            yelp_ids << activity['yelp_id']
          end

        place[:activities] = Activity.where(yelp_id: yelp_ids).to_a
      end

      @categories = place[:activities].map { |h| h['category'] }.uniq
    end
    end
    @trip = Trip.new
  end

  # Charlie: Nouvelle methode à appeler dans la boucle de la méthode précédente
  def findreviews(activity)
    apireviews = FetchReviewsService.new(activity[:yelp_id]).()["reviews"]
    apireviews.each do |review|
      activity.reviews << {
        name: review["user"]["name"],
        reviewtext: review["text"]
      }
    end
    activity.save
  end



  def profile
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :activity_ids)
  end

end
