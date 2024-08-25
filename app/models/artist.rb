class Artist < ApplicationRecord
  belongs_to :user
  has_many :lives, class_name: "Live", dependent: :destroy
  validates :user_id, presence: true
end
