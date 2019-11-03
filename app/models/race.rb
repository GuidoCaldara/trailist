class Race < ApplicationRecord
  belongs_to :organization
  has_many :race_photos
  has_many :race_prices
  geocoded_by :location
  after_validation :geocode
end
