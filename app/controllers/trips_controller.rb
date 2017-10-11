class TripsController < ApplicationController
  attr_accessor :hash_city
  def index
    # @trips = current_user.trips
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
    @alert_message = "Here is your optimized trip!"
    @activities_per_place = group_by_place
    @sliced_activities = []
    @hash = {}
    @activities_per_place.each do |city, activities|
      @sliced_activities << slice(activities)
      @hash[city] = set_coords_and_markers(slice(activities))
    end
    @cities = @hash.keys
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = current_user.trips.new(trip_params)
    if @trip.save
      redirect_to trip_path(@trip)
    else
      render :new
    end

  end

  def edit
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, activity_ids: [])
  end


  def group_by_place
    @trip.activities.group_by{ |h| h[:place_name] }
  end

  def slice(group)
    @a_activities_day = []
    group.each_slice(3) { |a| @a_activities_day << a }
    @a_activities_day
  end

  def set_coords_and_markers(activities_per_place_and_day)
    activities_per_place_and_day = activities_per_place_and_day.flatten
    @city = activities_per_place_and_day.first.place_name
    @activities_map = []
    activities_per_place_and_day.each do |activity|
      if (activity.latitude && activity.longitude)
        @activities_map << activity
      end
    end
    markers_hash = Gmaps4rails.build_markers(@activities_map.flatten) do |activity, marker|
      marker.lat activity.latitude
      marker.lng activity.longitude
    end
    markers_hash
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
