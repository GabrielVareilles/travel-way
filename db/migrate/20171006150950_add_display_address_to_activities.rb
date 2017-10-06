class AddDisplayAddressToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :display_address, :string
  end
end
