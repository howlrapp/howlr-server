module Karma
  def self.rules_for(user)
    {}.tap do |rules|
      if user.bio.blank? && user.like.blank?
        rules[:bio_and_like_blank] = -4
      end

      if user.avatar.blank?
        rules[:avatar_blank] = -3
      end

      if user.profile_field_values.empty?
        rules[:empty_profile_field_values] = -2 
      end

      if user.group_ids_cache.empty?
        rules[:empty_groups] = -2
      end

      # Add your own rules here
    end
  end
end
