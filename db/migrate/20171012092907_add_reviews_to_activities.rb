class AddReviewsToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :reviews, :text
  end
end
