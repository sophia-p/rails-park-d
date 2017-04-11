class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :spot
  validates :points, :username, presence: true
  validates :username, uniqueness: true

  def precheckout_point
    self.points += 2
  end

  def checkout_point
    self.points += 1
  end
end
