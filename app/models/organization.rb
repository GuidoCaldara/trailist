class Organization < ApplicationRecord
  belongs_to :user
  has_many :races, dependent: :destroy
  has_many :reviews, through: :races
  mount_uploader :logo, LogoUploader
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :email, presence: true, email: true
  validates :location, presence: true
  validates :website, url: { allow_blank: true }

end
