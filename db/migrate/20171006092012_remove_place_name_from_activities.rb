class RemovePlaceNameFromActivities < ActiveRecord::Migration[5.1]
  def change
    remove_column :activities, :place_name, :string
  end
end
