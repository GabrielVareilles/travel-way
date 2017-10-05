class TripsController < ApplicationController

  def index
    # @trips = current_user.trips
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
    @groups_place = group_by_place
    @sliced_activities = []
    @groups_place.each do |group|
      @sliced_activities << slice(group)
    end
  end

  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
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
    params.require(:trip).permit(:name, :start_date, :end_date, places: [])
  end


  def group_by_place
    @trip.activities.group_by{ |h| h[:place_name] }.values
  end

  def slice(group)
    a_activities_day = []
    group.each_slice(3) { |a| a_activities_day << a }
    a_activities_day
  end


end
