class AddActivitiestoTrips < ActiveRecord::Migration[5.1]
  def change
    add_column :trips, :activity_ids, :string, array: true, default: []
  end
end
