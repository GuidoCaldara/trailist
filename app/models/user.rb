class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  #validates :username, presence: true, on: :update
  has_one :organization
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
