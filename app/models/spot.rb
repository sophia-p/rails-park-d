class Spot < ApplicationRecord
	belongs_to :user
	validates :long, :lat, :precheckout, :checkout, presence: true

	def precheckout
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
end
