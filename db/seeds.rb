# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
trips = %w(Rome2017 Lille2018 Paris2015 Lyon2004)
activities = %w(placeprincipale museebeauxarts chocolaterie)
categories = %w(food arts parcs)
place = %w(Paris Lille Lyon)

Trip.destroy_all
Activity.destroy_all

10.times do
trip = Trip.new(
  name: trips.sample,
  start_date: Time.new(2002, 10, 31),
  end_date: Time.new(2002, 11, 26),
  places: ['Paris', 'Lille', 'Lyon']
  )
trip.save
7.times do
  activity = Activity.new(
    name: activities.sample,
    category: categories.sample,
    long: 3.066667,
    lat: 50.633333,
    place_name: place.sample,
    trip: trip
    )
activity.save
end
end

puts 'finished'
