class MatchKindUser < ApplicationRecord
  self.primary_key = :uuid
  self.table_name = "match_kinds_users"

  belongs_to :user, touch: true
  belongs_to :match_kind
end
