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


Activity.destroy_all
Trip.destroy_all

10.times do
  trip = Trip.new(
    name: trips.sample,
    start_date: Time.new(2002, 10, 31),
    end_date: Time.new(2002, 11, 26),
    places: ['Paris', 'Lille', 'Lyon']
    )
  trip.save

  activity1 = Activity.new(
    name: activities.sample,
    category: categories.sample,
    latitude: 48.8648482,
    longitude: 2.379853400000002,
    place_name: 'Paris',
    trip: trip,
    address: '16 Villa Gaudelet, Paris'
    )
  activity1.save
  activity2 = Activity.new(
    name: activities.sample,
    category: categories.sample,
    latitude: 48.88474129999999,
    longitude: 2.340531800000008,
    place_name: 'Paris',
    trip: trip,
    address: '24 Rue la Vieuville, Paris'
    )
  activity2.save
  activity3 = Activity.new(
    name: activities.sample,
    category: categories.sample,
    latitude: 48.8717232,
    longitude: 2.314820599999962,
    place_name: 'Paris',
    trip: trip,
    address: '112 rue du Faubourg Saint Honoré, Paris'
    )
  activity3.save
  activity4 = Activity.new(
    name: activities.sample,
    category: categories.sample,
    latitude: 48.88474129999999,
    longitude: 2.340531800000008,
    place_name: 'Lille',
    trip: trip,
    address: '26 rue Basse, Lille'
    )
  activity4.save
  activity5 = Activity.new(
    name: activities.sample,
    category: categories.sample,
    latitude: 50.639415,
    longitude: 3.0581309000000374,
    place_name: 'Lille',
    trip: trip,
    address: '21 rue Royale, Lille'
    )
  activity5.save
  activity6 = Activity.new(
    name: activities.sample,
    category: categories.sample,
    latitude: 50.6390312,
    longitude: 3.0629811999999674,
    place_name: 'Lille',
    trip: trip,
    address: '11 rue Basse, Lille'
    )
  activity6.save
  activity7 = Activity.new(
    name: activities.sample,
    category: categories.sample,
    latitude: 43.59629949999999,
    longitude: 7.111838000000034,
    place_name: 'Antibes',
    trip: trip,
    address: '220 chemin de Beauvert, Antibes'
    )
  activity7.save
  activity8 = Activity.new(
    name: activities.sample,
    category: categories.sample,
    latitude: 43.5903542,
    longitude: 7.098216099999945,
    place_name: 'Antibes',
    trip: trip,
    address: '427 chemin des Âmes du Purgatoire, Antibes'
    )
  activity8.save
  activity9 = Activity.new(
    name: activities.sample,
    category: categories.sample,
    latitude: 43.580858,
    longitude: 7.127487999999971,
    place_name: 'Antibes',
    trip: trip,
    address: 'Cours Masséna, Antibes'
    )
  activity9.save
end

puts 'finished'



