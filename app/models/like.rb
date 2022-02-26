class Like < ApplicationRecord
  self.primary_key = :uuid

  belongs_to :liker, class_name: "User", touch: true
  belongs_to :liked, class_name: "User", touch: true, counter_cache: :likers_count

  validates :liked, uniqueness: { scope: :liker }

  after_commit :update_ids_caches

  private

  def update_ids_caches
    unless liker.frozen?
      liker.update(liked_ids_cache: liker.liked_ids)
    end

    unless liked.frozen?
      liked.update(liker_ids_cache: liked.liker_ids)
    end
  end

end
