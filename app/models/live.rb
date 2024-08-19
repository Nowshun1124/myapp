class Live < ApplicationRecord
  belongs_to :artist

  validates :latitude, presence: true
  validates :longitude, presence: true
end
