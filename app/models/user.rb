class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :destinations
  has_many :spots
  has_one :tier

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

  def current_destination
    self.destinations.last
  end

  def precheckout_point
    self.points += 2
  end

  def checkout_point
    self.points += 1
  end

  def tier
    radius = 0.0034
    if self.points > 200
      {name: "Hall of Fame", spots: 25, radius: radius*2}
    elsif self.points > 150
      {name: "MVP", spots: 20, radius: radius*2}
    elsif self.points > 100
      {name: "All-Star", spots: 15, radius: radius*2}
    elsif self.points > 75
      {name: "Pro", spots: 10, radius: radius*2}
    elsif self.points > 50
      {name: "Semi-Pro", spots: 6, radius: radius}
    elsif self.points > 25
      {name: "Amateur", spots: 4, radius: radius}
    else
      {name: "Rookie", spots: 2, radius: radius}
    end

  end


end
