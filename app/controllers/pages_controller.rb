#require_relative '../services/fetch_rome2rio_service.rb'
require "open-uri"
require "nokogiri"


class PagesController < ApplicationController
  def home
  end

  def testapi
    @results = FetchRome2RioService.new('Lille', 'Lyon').()
  end

  def setplaces
    @trip = Trip.new
  end

  def setactivities
    @places = []

    params['trip']['places'].each do |place|
      @places << { name: place, activities: [] }
    end

    @places.each do |place|
      ActivitiesCategories::CATEGORIES.each do |category|
        category.each do |elem|
          results = FetchActivitiesService.new(elem, place[:name]).()

          place[:activities] << results
        end
       end
     end
     @trip = Trip.new
  end
end




class FetchRome2RioService

  def initialize(startpoint, endpoint)
    @id = ENV['ROME2RIO_KEY']
    @startpoint = startpoint
    @endpoint = endpoint
  end

  def call
    url = "http://free.rome2rio.com/api/1.4/json/Search?key=#{@id}&oName=#{@startpoint}&dName=#{@endpoint}"
    result_serialized = open(url).read
    @result = JSON.parse(result_serialized)
  end

end
