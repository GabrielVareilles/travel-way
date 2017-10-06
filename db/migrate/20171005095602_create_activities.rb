class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.string :category
      t.float :long
      t.float :lat
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
