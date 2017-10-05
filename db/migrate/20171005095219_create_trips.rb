class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.string :name
      t.references :user, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :places, array: true, default: []

      t.timestamps
    end
  end
end
