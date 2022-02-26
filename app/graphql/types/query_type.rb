module Types
  class QueryType < Types::BaseObject
    field :app, AppType, null: false

    field :viewer, Types::ViewerType, null: true
    field :session, Types::SessionType, null: true
    field :session_by_code, SessionType, null: true do
      argument :code, String, required: true
    end

    def app
      { id: Rails.configuration.app_name }
    end

    def viewer
      context[:current_user].tap do |viewer|
        raise Pundit::NotAuthorizedError unless UserPolicy.new(context[:current_user], viewer).show?

        viewer.update(last_seen_at: DateTime.now) if (viewer.last_seen_at || DateTime.now) < 1.minute.ago
      end
    end

    def session
      context[:current_session].tap do |session|
        raise Pundit::NotAuthorizedError unless SessionPolicy.new(context[:current_user], session).update?

        context[:current_session].update({
          ip: context[:ip],
          last_seen_at: DateTime.now
        })
      end
    end

    def session_by_code(code:)
      if code == Rails.configuration.apple_sign_up_code
        # :nocov:
        # Do we already have an existing session with this code?
        Session.find_or_create_by(code: Rails.configuration.apple_sign_up_code) do |session|
          # If the session wasn't already created, we create a new user for it
          # if it doesn't exist
          session.user = User.find_or_create_by(telegram_id: "apple_reviewer") do |user|
            user.name = SecureRandom.uuid.split('-')[0] 
          end
        end
        # :nocov:
      else
        session = Session.where("code_expiration_date > ?", Time.now).find_by(code: code)

        if session.blank? || session.user.blank? || session.user.is_banned? || session.code_expiration_date < Time.now
          raise Pundit::NotAuthorizedError
        else
          session.update(code: nil, ip: context[:ip], last_seen_at: DateTime.now)
          session
        end
      end.tap do |session|
        ensure_localities! session.user
      end
    end

    protected

    def ensure_localities!(user)
      return if context[:ip].blank? || user.localities.present?

      if result = Geocoder.search(context[:ip])&.first
        locality_attributes = Geometry.find_localities(result.latitude, result.longitude)
        return if locality_attributes.nil? # Should not happen if geometries are loaded

        user.update(
          latitude: locality_attributes[:latitude],
          longitude: locality_attributes[:longitude],
          localities: locality_attributes[:localities],
        )

        # Allow the user to immediatly change their location
        user.update(location_changed_at: nil)
      end
    end
  end
end
