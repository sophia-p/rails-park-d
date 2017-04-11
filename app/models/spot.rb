class Spot < ApplicationRecord
	before_create :set_checkouts
	belongs_to :user
	validates :long, :lat, :precheckout, :checkout, presence: true

	def precheckout
		self.user.points += 10
		self.precheckout = true
	end

	def checkout
		self.checkout = true
	end

	def destroy_spot
		if self.checkout == true && self.updated_at < Time.current - (5*60)
			self.destroy
		end
	end


	# def spots_within_radius
	# end

	def set_checkouts
		self.precheckout = false
		self.checkout = false
	end
end
