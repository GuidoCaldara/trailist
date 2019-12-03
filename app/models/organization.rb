class Organization < ApplicationRecord
  belongs_to :user
  has_many :races, dependent: :destroy
  has_many :reviews, through: :races
  mount_uploader :logo, LogoUploader
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
