class AddPlaceNameToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :place_name, :string
  end
end
