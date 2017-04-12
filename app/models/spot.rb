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


	def self.spot_in_range(lat, lng)
		# +/-0.00003
		lat = lat.round(4)
		lng = lng.round(4)
		self.find_by(lat: lat, lng: lng)
	end

	def checkout?
		self.checkout = true
	end

	def timelapsed_checkout
		if self.precheckout == true && self.updated_at < Time.current - (5*60)
			self.update(checkout: true)
		end
	end

	def destroy_spot
		if self.checkout == true && self.updated_at < Time.current - (2*60)
			self.destroy
		end
	end

	def self.spot_refresh
		self.each do |spot|
			spot.timelapsed_checkout
			spot.destroy_spot
		end
	end

	# def spots_within_radius
	# end

	def set_checkouts
		self.precheckout = false
		self.checkout = false
	end

	def points_awarded
		if self.precheckout
      self.user.precheckout_point
    else
      self.user.checkout_point
    end
	end


end
