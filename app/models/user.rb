class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :spot
  validates :points, :username, presence: true
  validates :username, uniqueness: true

  # def active_spots
  # 	active_spots = []
  # 	if self.spot && self.spot.checkout == true
  # 		active_spots << spot
  # 	end
  # end



end
