class Spot < ApplicationRecord

	before_create :set_checkouts
	belongs_to :user
	validates :lng, :lat, presence: true


	# def precheckout
	# 	if self.user != nil
	# 		self.user.points += 10
	# 	end
	# 	self.precheckout = true
	# end

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
