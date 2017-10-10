class AddYelpIdToActivities < ActiveRecord::Migration[5.1]
  def change
     add_column :activities, :yelp_id, :string
  end
end
