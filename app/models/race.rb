class Race < ApplicationRecord
  include PgSearch::Model
  extend FriendlyId
  friendly_id :name, use: :slugged
  CATEGORIES = %w(Vertical Skyrace Trail Ultra)
  DISTANCES = %w(0-21 22-42 43-100 >100)
  DISTANCE_TYPES = %w(short medium long ultra)
  belongs_to :organization
  has_many :race_photos, dependent: :destroy
  has_many :race_prices, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :race_type, presence: true, inclusion: { in: CATEGORIES }
  validates :name, presence: true, uniqueness: true
  validates :length, presence: true, numericality: { only_integer: true, greater_than: 1, less_than: 400}
  validates :elevation, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 35000}
  validate :elevation_format
  validates :location, :departure_time, :date,  presence: true
  validates :description, presence: true, length: { minimum: 200 }
  validate :date_in_the_future
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  before_save :set_distance_type


  pg_search_scope :search_by_name, against: :name, using: { tsearch: { prefix: true } }
  scope :filter_by_type, ->(types) { where(race_type: types) }
  scope :filter_by_distance, ->(distances) { where(distance_type: distances) }
  scope :filter_by_date, ->(start_date, end_date) { where("date >= ? AND date <= ?", start_date, end_date) }

  def elevation_format
    if !elevation.nil? && (elevation % 10) != 0
      errors.add(:elevation, 'Inserisci un dislivello multiplo di 10')
    end
  end

  def date_in_the_future
    if !date.nil? &&  date <= Date.today
      errors.add(:date, 'Inserisci una data futura')
    end
  end

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
