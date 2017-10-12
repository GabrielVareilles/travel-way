class Activity < ApplicationRecord
  has_and_belongs_to_many :trips
  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  geocoded_by :display_address
  after_validation :geocode, if: :display_address_changed?

  serialize :reviews, Array
end
