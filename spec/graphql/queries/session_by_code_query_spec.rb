require 'rails_helper'

RSpec.describe 'Queries::SessionByCodeQuery' do
  let(:user) { FactoryBot.create :user }
  let(:session) { FactoryBot.create :session, user: user }

  GET_SESSION_BY_CODE = %{
    query getSessionByCode($code: String!) {
      sessionByCode(code: $code) {
        id
      }
    }
  }

  context "valid_params" do
    it "can get session with valid code" do
      geocoder_result = instance_double("GeocoderResult", latitude: 20, longitude: 20)
      allow(Geocoder)
        .to receive(:search)
        .and_return [geocoder_result]

      expect(user.localities).to eq([])

      result = HowlrSchema.execute(GET_SESSION_BY_CODE,
        context: {
          ip: "159.253.158.30" # IBM owned IP
        },
        variables: { code: session.code }
      )
      expect(result["data"]["sessionByCode"]["id"]).to eq(session.id)
      user.reload

      expect(user.lonlat.latitude).to_not eq(nil)
      expect(user.lonlat.latitude).to_not eq(0.0)

      expect(user.lonlat.longitude).to_not eq(nil)
      expect(user.lonlat.longitude).to_not eq(0.0)

      expect(user.localities).to eq(["Chad", "Borkou", "Aozi"])
      expect(user.location_changed_at).to eq(nil)
    end

    it "can get banned" do
      Ban.create(user: user)

      result = HowlrSchema.execute(GET_SESSION_BY_CODE,
        context: {
          ip: "159.253.158.30" # IBM owned IP
        },
        variables: { code: session.code }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end

  context "invalid_params" do
    it "can not get session with invalid code" do
      result = HowlrSchema.execute(GET_SESSION_BY_CODE,
        context: {
          ip: "159.253.158.30" # IBM owned IP
        },
        variables: { code: "invalid_code" }
      )
      expect(result["errors"][0]["message"]).to eq("Not authorized")
    end
  end
end
