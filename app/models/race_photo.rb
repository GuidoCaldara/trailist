class RacePhoto < ApplicationRecord
  mount_uploader :picture, PhotoUploader
  belongs_to :race
end
