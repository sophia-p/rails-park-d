class Spot < ApplicationRecord
	belongs_to :user
	validates :long, :lat, :precheckout, :checkout, presence: true

	def precheckout
		self.precheckout = true
	end

	def checkout
		self.checkout = true
	end
end
