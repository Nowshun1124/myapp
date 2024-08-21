class Artist < ApplicationRecord
  belongs_to :user
  has_many :lives, class_name: "Live"
  validates :user_id, presence: true
end
