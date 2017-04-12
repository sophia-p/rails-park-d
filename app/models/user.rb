class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :spot
  has_many :destinations
  validates :points, :username, presence: true
  validates :username, uniqueness: true


  def activate_spots
  	active_spots = []
  	if self.spot && self.spot.checkout == true
  		active_spots << spot
  	end
  end

  def current_destination
    self.destinations.last
  end




  def precheckout_point
    self.points += 2
  end

  def checkout_point
    self.points += 1
  end

end
