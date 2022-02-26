class User < ApplicationRecord
  self.primary_key = :uuid

  belongs_to :relationship_status, optional: true

  has_many :gender_users, dependent: :destroy
  has_many :genders, through: :gender_users

  has_many :sexual_orientation_users, dependent: :destroy
  has_many :sexual_orientations, through: :sexual_orientation_users

  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users

  has_many :match_kind_users, dependent: :destroy
  has_many :match_kinds, through: :match_kind_users

  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures, allow_destroy: true

  has_many :chats_as_sender, class_name: "Chat", foreign_key: :sender_id, dependent: :destroy, inverse_of: :sender
  has_many :chats_as_recipient, class_name: "Chat", foreign_key: :recipient_id, dependent: :destroy, inverse_of: :recipient

  has_many :recipients, class_name: "User", through: :chats_as_sender
  has_many :senders, class_name: "User", through: :chats_as_recipient

  has_many :sessions, dependent: :destroy
  accepts_nested_attributes_for :sessions, allow_destroy: true

  has_many :likes_as_liker, class_name: "Like", foreign_key: :liker_id, dependent: :destroy, inverse_of: :liker
  has_many :likes_as_liked, class_name: "Like", foreign_key: :liked_id, dependent: :destroy, inverse_of: :liked

  has_many :likers, class_name: "User", through: :likes_as_liked
  has_many :likeds, class_name: "User", through: :likes_as_liker

  has_many :events_as_owner, class_name: "Event", dependent: :destroy

  has_many :event_users, dependent: :destroy
  has_many :events_as_participant, class_name: "Event", through: :event_users, source: :event

  has_many :bans
  accepts_nested_attributes_for :bans, allow_destroy: true

  has_many :reports_as_reporter, class_name: 'Report', foreign_key: :reporter_id
  has_many :reports_as_reported, class_name: 'Report', foreign_key: :subject_id

  mount_base64_uploader :avatar, AvatarUploader, file_name: -> (u) { SecureRandom.uuid }

  attribute :latitude, :float
  attribute :longitude, :float

  validates :distance_unit, inclusion: { in: %w(kilometers miles) }
  validates :telegram_id, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: Rails.configuration.maximum_name_length }
  validates :bio, length: { maximum: Rails.configuration.maximum_fields_length }
  validates :like, length: { maximum: Rails.configuration.maximum_fields_length }
  validates :dislike, length: { maximum: Rails.configuration.maximum_fields_length }

  before_create :set_default_match_kinds
  before_create :set_default_restricted_profile_fields

  before_save :set_age_cache

  before_save :set_match_kind_ids_cache
  before_save :set_gender_ids_cache
  before_save :set_sexual_orientation_ids_cache

  before_save :set_group_ids_cache

  before_save :set_karma

  before_save :store_lonlat, if: Proc.new { |record|
    record.longitude.present? && record.latitude.present?
  }

  before_save :set_location_changed_at, if: Proc.new { |record|
    record.longitude_changed? || record.latitude_changed?
  }

  after_commit :update_localities!, on: [:update], if: Proc.new { |record|
    record.lonlat_previously_changed?
  }

  def update_localities!
    return unless saved_change_to_lonlat? && lonlat.present?

    update(localities: Geometry.find_localities(lonlat.latitude, lonlat.longitude)[:localities])
  rescue => exception
    # :nocov:
    ExceptionNotifier.notify_exception exception, data: { user: self.attributes }
    # :nocov:
  end

  def compute_age
    now = (Time.now.utc + 12.hours).to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def unread_chats_count
    chats_as_sender.where(is_sender_unread: true).count + chats_as_recipient.where(is_recipient_unread: true).count
  end

  def is_banned?
    Ban.find_last_active_ban_for(telegram_id).present?
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

  def store_lonlat
    self.lonlat = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
  end

  def set_location_changed_at
    self.location_changed_at = DateTime.now
  end

  def set_default_match_kinds
    self.match_kind_ids = MatchKind.pluck(:uuid)
  end

  def set_age_cache
    self.age_cache = compute_age if birthdate.present?
  end

  def set_match_kind_ids_cache
    self.match_kind_ids_cache = match_kind_ids
  end

  def set_gender_ids_cache
    self.gender_ids_cache = gender_ids
  end

  def set_sexual_orientation_ids_cache
    self.sexual_orientation_ids_cache = sexual_orientation_ids
  end

  def set_group_ids_cache
    self.group_ids_cache = group_ids
  end

  def set_default_restricted_profile_fields
    self.restricted_profile_fields = ProfileField.where(restricted: true).pluck(:name)
  end

  def set_karma
    self.karma = Karma.rules_for(self).values.sum + karma_boost
  end

  def karma_ok?
    self.karma >= Rails.configuration.karma_limit
  end
end
