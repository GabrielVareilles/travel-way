class PagesController < ApplicationController
  def home
  end

  def setplaces
    @trip = Trip.new
  end

  def setactivities
    @places = params['trip']['places']
  end
end
