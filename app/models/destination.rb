class Destination < ApplicationRecord
  belongs_to :user
  validates :des_lat, :des_lng, presence: true


end
