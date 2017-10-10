class DropActivitiesTripsTableTable < ActiveRecord::Migration[5.1]
  def up
    drop_table :activities_trips
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
