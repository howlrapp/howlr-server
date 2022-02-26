Geocoder.configure(
  timeout: 2,
  ip_lookup: :freegeoip,
  api_key: ENV["FREEGEOIP_API_KEY"],
  units: :km
)
