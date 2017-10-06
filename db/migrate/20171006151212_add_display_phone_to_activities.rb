class AddDisplayPhoneToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :display_phone, :string
  end
end
