class RemoveLongFromActivities < ActiveRecord::Migration[5.1]
  def change
    remove_column :activities, :long, :float
  end
end
