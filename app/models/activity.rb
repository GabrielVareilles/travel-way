class Activity < ApplicationRecord
  has_and_belongs_to_many :trips
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true, uniqueness: true
  validates :latitude, presence: true, uniqueness: true
  validates :longitude, presence: true , uniqueness: { scope: :latitude }
  validates :latitude, presence: true
  geocoded_by :display_address
  after_validation :geocode, if: :display_address_changed?
end
