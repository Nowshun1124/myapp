class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  validate :follower_is_listener
  validate :followed_is_artist

  private
    def follower_is_listener
      errors.add(:follower, "リスナーでなければいけません") unless follower.listener?
    end

    def followed_is_artist
      errors.add(:followed, "アーティスト以外はフォローできません") unless followed.artist?
    end
end
