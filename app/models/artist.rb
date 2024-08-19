class Artist < ApplicationRecord
  belongs_to :user
  has_one :live
  validates :user_id, presence: true
end
