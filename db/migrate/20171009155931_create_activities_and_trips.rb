class CreateActivitiesAndTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :activities_trips, id: false do |t|
      t.belongs_to :activities, index: true
      t.belongs_to :trips, index: true
    end
  end
end
