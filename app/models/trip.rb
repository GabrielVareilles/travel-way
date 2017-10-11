class Trip < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :activities
  before_save :remove_blank_places

  def remove_blank_places
    places.reject!(&:blank?)
  end
end
