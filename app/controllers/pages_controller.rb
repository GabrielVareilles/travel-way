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
    params['trip']['places'].each do |place|
      @places << { name: place, activities: [] }
    end

    @places.each do |place|
      ActivitiesCategories::CATEGORIES.each do |category|
        category.each do |subcategory|
          results = FetchActivitiesService.new(subcategory, place[:name]).()
          results.map! { |activity| activity.to_h }
          results.each { |activity| activity[:category] = category[0] } # on met les activity sous forme de hash dans results
          results.each { |activity| activity[:yelp_id] = activity[:id] }
          results.each { |activity| activity.delete(:id) }
          results.each { |activity| activity[:latitude] = activity[:coordinates]['latitude'] }
          results.each { |activity| activity[:longitude] = activity[:coordinates]['longitude'] }
          results.each { |activity| activity.delete(:coordinates) }
          results.each { |activity| activity[:place_name] = activity[:location]['city'] }
          results.each { |activity| activity[:display_address] = activity[:location]['display_address'] }
          results.each { |activity| activity.delete(:location) }

          place[:activities] << results.flatten
          place[:activities].flatten!
          place[:activities].map! { |activity| activity.is_a?(Hash) ? activity : activity.attributes }

        end
        place[:activities].map! do |activity|
          new_activity = Activity.find_or_initialize_by(yelp_id: activity[:yelp_id])
          new_activity.save
          new_activity.update_attributes(activity)
          new_activity
        end
      end
      @categories = place[:activities].map { |h| h[:category] }.uniq
    end
    @trip = Trip.new
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :activity_ids)
  end

end
