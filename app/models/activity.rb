class Activity < ApplicationRecord

  belongs_to :trip
  geocoded_by :display_address
  after_validation :geocode, if: :display_address_changed?

  has_and_belongs_to_many :projects
  # geocoded_by :display_address
  # after_validation :geocode, if: :display_address_changed?

end
