require 'rails_helper'


RSpec.describe Spot, type: :model do
include ActiveSupport::Testing::TimeHelpers

  describe "validations" do
  	let (:spot_without_longitude) {Spot.new(lat: 48)}
  	let (:spot_without_latitude) {Spot.new(lng: 48)}
  	let (:valid_spot) {Spot.new(lat: 30, lng: 60)}

	it "must have a longitude" do
		spot_without_longitude.valid?
		expect(spot_without_longitude.errors[:lng]).to_not be_empty
	end

	it "must have a longitude" do
		spot_without_latitude.valid?
		expect(spot_without_latitude.errors[:lat]).to_not be_empty
	end

	it "is valid with both latitude and longitude" do
		expect(valid_spot.errors).to be_empty
	end

  end

  describe "class methods" do
  		before(:each) do 
			@johndoe = User.create!(username:"johndoe", email:"johndoe@email.com", password: "123456")
			@spot_1 = @johndoe.spots.new(lat: 40.7098, lng: -74.0099)
		end

		context "default values" do

			it "has precheckout set to false upon insantiation" do		
				@spot_1.save!
				expect(@spot_1.precheckout).to be false
			end

			it "has checkout set to false upon insantiation" do		
				@spot_1.save!
				expect(@spot_1.checkout).to be false
			end
		end

		context "checkout methods" do

			# it "returns a spot if user is currently on an existing spot" do
			# 	@spot_1.save!
				
			# end
			it "sets checkout to true" do
				@spot_1.save!
				# @spot_1.checkout?
				expect{@spot_1.checkout?}.to change{@spot_1.checkout}.from(false).to(true)
			end


			it "sets checkout to true if precheckout was 5 minutes earlier" do
				@spot_1.save!
				@spot_1.precheckout =  true
				@spot_1.updated_at = Time.current - (5*60)
				expect{@spot_1.timelapsed_checkout}.to change{@spot_1.checkout}.from(false).to(true)
			end

		

			it "does not set checkout to true if precheckout was less than 5 minutes ago" do
				@spot_1.save!
				@spot_1.precheckout =  true
				@spot_1.updated_at = Time.current - (2*60)
				expect{@spot_1.timelapsed_checkout}.not_to change{@spot_1.checkout}
			end

			it "destroys a spot if user checked out 2 minutes ago" do
				@spot_1.save!
				@spot_1.checkout = true
				@spot_1.updated_at = Time.current - (2*60)
				expect{@spot_1.destroy_spot}.to change{@johndoe.spots.count}.by(-1)
			end

			it "does not destroy a spot if user checked out less than 2 minutes ago" do
				@spot_1.save!
				@spot_1.checkout = true
				expect{@spot_1.destroy_spot}.to change{@johndoe.spots.count}.by(0)
			end

			it "awards 2 points to user if user prechecksout" do
				@spot_1.save!
				@spot_1.precheckout = true
				expect{@spot_1.points_awarded}.to change{@johndoe.points}.by(2)
			end

			it "awards 1 points to user if user checksout" do
				@spot_1.save!
				@spot_1.checkout = true
				expect{@spot_1.points_awarded}.to change{@johndoe.points}.by(1)
			end
		end

  end

end
