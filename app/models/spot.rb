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


	def self.on_existing_spot(args)
		# +/-0.0001
		round_lat = args[:lat].to_i.round(4)
		round_lng = args[:lng].to_i.round(4)
		self.find_by(lat: round_lat, lng: round_lng)
	end

	def self.spots_in_range(args)
		# 0.0034
		tier = User.find(args[:user_id]).tier
		range = tier[:radius]
		lat_range = [args[:lat] - range, args[:lat] + range]
		long_range = [args[:lng] - range, args[:lng] + range]
		# byebug
		self.available_spots.where(lat: lat_range[0]..lat_range[1]).limit(tier[:spots])
	end

	def self.available_spots
		self.where("precheckout = true OR checkout = true")
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
		if self.checkout == true && self.updated_at < Time.current - (15*60)
			self.destroy
		end
	end

	def self.spot_refresh
		self.all.each do |spot|
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
