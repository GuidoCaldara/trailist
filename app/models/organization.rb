class Organization < ApplicationRecord
  belongs_to :user
  has_many :races
  has_many :reviews, through: :races
  mount_uploader :logo, LogoUploader
  geocoded_by :location
  after_validation :geocode
end
