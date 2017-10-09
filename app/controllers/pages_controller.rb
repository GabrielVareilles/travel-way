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
