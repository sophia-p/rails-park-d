require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe "validations" do
  	let (:spot_without_longitude) {Spot.new(lat: 48)}
  	let (:spot_without_latitude) {Spot.new(long: 48)}
  	let (:valid_spot) {Spot.new(lat: 30, long: 60)}

	it "must have a longitude" do
		spot_without_longitude.valid?
		expect(spot_without_longitude.errors[:long]).to_not be_empty
	end

	it "must have a longitude" do
		spot_without_latitude.valid?
		expect(spot_without_latitude.errors[:lat]).to_not be_empty
	end

	it "is valid with both latitude and longitude" do
		expect(valid_spot.errors).to be_empty
	end

  end

  describe "spot methods" do
  		before(:each) do 
			@johndoe = User.create!(username:"johndoe", email:"johndoe@email.com", password: "123456")
			@spot_1 = Spot.new(long: 74, lat: 42)
		end

		# it "has precheckout set to false upon insantiation" do
		# 	@johndoe.spot = @spot_1
		# 	@spot_1.save!
		# 	expect(@spot_1.precheckout).to be false
		# end

  end

end
