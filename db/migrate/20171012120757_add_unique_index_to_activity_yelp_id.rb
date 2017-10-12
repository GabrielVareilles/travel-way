class AddUniqueIndexToActivityYelpId < ActiveRecord::Migration[5.1]
  def change
    add_index :activities, :yelp_id, unique: true
  end
end
