class Event < ApplicationRecord
  self.primary_key = :uuid

  belongs_to :user
  belongs_to :event_category

  has_many :event_users
  has_many :users, through: :event_users

  has_many :reports_as_reported, class_name: 'Report', foreign_key: :subject_id

  validates :title, presence: true
  validates :address, presence: true
  validates :date, presence: true
  validates :maximum_searchable_distance, presence: true

  validates :lonlat, presence: true

  attribute :latitude, :float
  attribute :longitude, :float

  before_validation :store_lonlat, if: Proc.new { |record|
    attributes["longitude"].present? && attributes["latitude"].present?
  }

  after_commit :update_localities!, if: Proc.new { |record|
    record.lonlat_previously_changed?
  }

  def update_localities!
    return unless saved_change_to_lonlat? && lonlat.present?

    update(localities: Geometry.find_localities(lonlat.latitude, lonlat.longitude)[:localities])
  rescue => exception
    # :nocov:
    ExceptionNotifier.notify_exception exception, data: { event: self.attributes }
    # :nocov:
  end

  def store_lonlat
    self.lonlat = RGeo::Geographic.spherical_factory(srid: 4326).point(attributes["longitude"], attributes["latitude"])
  end

  def geometry
    "ST_SetSRID(ST_MakePoint(#{rounded_longitude}, #{rounded_latitude}), 4326)"
  end

  def rounded_latitude
    self.lonlat&.latitude&.round(2)
  end

  def rounded_longitude
    self.lonlat&.longitude&.round(2)
  end
end
