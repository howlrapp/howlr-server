module Types
  class UserSummaryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :avatar_url, String, null: true
    field :online, Boolean, null: false
    field :distance, Integer, null: false
    field :system, Boolean, null: false

    def avatar_url
      object.avatar_url(:tiny)
    end

    def online
      !!(object.share_online_status && object.last_seen_at.present? && object.last_seen_at > Rails.configuration.online_duration.minutes.ago)
    end

    def distance
      distance = Geocoder::Calculations.distance_between(
        [ context[:current_user].rounded_latitude, context[:current_user].rounded_longitude ],
        [ object.rounded_latitude, object.rounded_latitude ],
        { units: :km }
      ) || 0

      roundings = {
        30 => 10,
        100 => 20,
        1000 => 100,
        10000 => 1000,
        100000 => 10000
      }.each do |limit, rounding|
        if distance < limit
          return (distance / rounding).floor * rounding
        end
      end

      # This should never happen
      # :nocov:
      0
      # :nocov:
    end
  end
end
