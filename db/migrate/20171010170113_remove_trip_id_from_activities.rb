class RemoveTripIdFromActivities < ActiveRecord::Migration[5.1]
  def change
    remove_column :activities, :trip_id
  end
end
