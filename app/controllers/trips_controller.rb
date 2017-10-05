class TripsController < ApplicationController

  def index
    # @trips = current_user.trips
    @trips = Trip.all
  end

  def show
    @trip = Trip.find(params[:id])
    @days = slice.size
    @a_activities_day = slice
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

  def slice
    a_activities_day = []
    @trip.activities.each_slice(3) { |a| a_activities_day << a }
    a_activities_day
  end
end
