class CreateActivitiesTripsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_table :activities_trips, id: false do |t|
      t.integer :activities_id
      t.integer :trips_id
    end
  end
end
