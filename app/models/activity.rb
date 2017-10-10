class Activity < ApplicationRecord
  belongs_to :trip
  geocoded_by :display_address
  after_validation :geocode, if: :display_address_changed?
end
