class Organization < ApplicationRecord
  belongs_to :organizer
  mount_uploader :logo, LogoUploader
  geocoded_by :location
  after_validation :geocode
end
