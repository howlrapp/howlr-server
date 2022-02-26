module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_session

    def connect
      self.current_session = find_verified_session
    end

    protected

    def find_verified_session
      Session.find_by(uuid: request.params[:token]).tap do |session|
        return reject_unauthorized_connection unless session.present?
      end
    end
  end
end
