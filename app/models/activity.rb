class Activity < ApplicationRecord
  has_and_belongs_to_many :trips
  # geocoded_by :display_address
  # after_validation :geocode, if: :display_address_changed?
end
