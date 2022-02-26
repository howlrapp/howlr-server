class Geometry < ApplicationRecord
  def self.best_matches_by_location(latitude, longitude)
    scope = self.select(:cached_name, :cached_hierarchy, :lonlat)

    # First we search if our point is within a known boundary
    locality_within = scope
      .where("geometries.geom IS NOT NULL AND ST_Within(ST_SetSRID(ST_MakePoint(?, ?), 4326), geometries.geom)", longitude.to_f, latitude.to_f)
    return locality_within if locality_within.present?

    # If not, we search for a close by boundary
    locality_closest = scope
      .where("geometries.geom IS NOT NULL AND ST_DWithin(ST_SetSRID(ST_MakePoint(?, ?), 4326), geometries.geom, 1)", longitude.to_f, latitude.to_f)
      .order(Arel.sql("geometries.geom <-> ST_SetSRID(ST_MakePoint(#{longitude.to_f}, #{latitude.to_f}), 4326)"))
    return locality_closest if locality_closest.present?

    # If nothing comes out, we pick the closest location
    scope.order(Arel.sql("geometries.lonlat <-> ST_SetSRID(ST_MakePoint(#{longitude.to_f}, #{latitude.to_f}), 4326)"))
  end

  def self.find_localities(latitude, longitude)
    locality = best_matches_by_location(latitude, longitude).limit(1).first
    return unless locality.present?

    country = locality.cached_hierarchy["empire"] || locality.cached_hierarchy["country"]
    region = locality.cached_hierarchy["macroregion"] || locality.cached_hierarchy["region"] || locality.cached_hierarchy["county"]

    {
      latitude: locality.lonlat.latitude,
      longitude: locality.lonlat.longitude,
      localities: [
        country || region || locality.cached_name,
        region || country || locality.cached_name,
        locality.cached_name || region || country
      ]
    }
  end
end
