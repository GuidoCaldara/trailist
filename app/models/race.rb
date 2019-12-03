class Race < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId
  friendly_id :name, use: :slugged
  CATEGORIES = [ "Vertical", "Skyrace", "Trail", "Ultra"]
  DISTANCES = [ "0-21", "22-42", "43-100", ">100"]
  DISTANCE_TYPES = ["short", "medium", "long", "ultra"]
  belongs_to :organization
  has_many :race_photos, dependent: :destroy
  has_many :race_prices, dependent: :destroy
  has_many :reviews, dependent: :destroy
  geocoded_by :location
  validates :name, presence: true
  after_validation :geocode, if: :will_save_change_to_location?
  before_save :set_distance_type

  pg_search_scope :search_by_name, against: :name, using: { tsearch: { prefix: true } }

  scope :filter_by_type, ->(types) { where(race_type: types) }
  scope :filter_by_distance, ->(distances) { where(distance_type: distances) }
  scope :filter_by_date, ->(start_date, end_date) { where("date >= ? AND date <= ?", start_date, end_date) }

  def set_distance_type
    if self.length <= 21
      self.distance_type = "short"
    elsif self.length <= 42
      self.distance_type = "medium"
    elsif self.length <= 100
      self.distance_type = "long"
    else
      self.distance_type = "ultra"
    end
  end

end
