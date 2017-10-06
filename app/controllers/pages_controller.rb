require_relative "../services/fetch_activities_service"
require_relative "../services/defining_activities_categories_service"

class PagesController < ApplicationController
  def home
  end

  def setplaces
    @trip = Trip.new
  end

  def setactivities
    @businesses = []
    @places = params['trip']['places']
    @places.each do |place|
      CATEGORIES.each do |category|
        category.each do |elem|
          results = search(elem, place)
          @businesses << results['businesses']
        end
       end
     end
  end
end
