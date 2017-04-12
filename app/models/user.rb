class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :spots
  validates :points, :username, presence: true
  validates :username, uniqueness: true

  def checkedin_spot?
    self.spots.where(user_id: self.id, precheckout: false, checkout: false).length > 0
  end

  def checkedin_spot
    self.spots.find_by(user_id: self.id, precheckout: false, checkout: false)
  end

  def activate_spots
  	active_spots = []
  	if self.spot && self.spot.checkout == true
  		active_spots << spot
  	end
  end

  def precheckout_point
    self.points += 2
  end

  def checkout_point
    self.points += 1
  end


end
