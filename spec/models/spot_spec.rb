require 'rails_helper'


RSpec.describe Spot, type: :model do

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
  	let(:spot) {FactoryGirl.create(:spot)}
  # 		before(:each) do 
		# 	@johndoe = User.create!(username:"johndoe", email:"johndoe@email.com", password: "123456")
		# 	@spot_1 = @johndoe.spots.new(lat: 40.7098, lng: -74.0099)
		# end

		context "default values" do
			it "has precheckout set to false upon insantiation" do		
				
				expect(spot.precheckout).to be false
			end

			it "has precheckout set to false upon insantiation" do		
				expect(spot.precheckout).to be false
			end

			it "has checkout set to false upon insantiation" do		
				expect(spot.checkout).to be false
			end
		end

		context "checkout methods" do


			it "sets checkout to true" do
				expect{spot.checkout?}.to change{spot.checkout}.from(false).to(true)
			end


			it "sets checkout to true if precheckout was 5 minutes earlier" do
				spot.precheckout = true
				Timecop.travel(5*60) do
					expect{spot.timelapsed_checkout}.to change{spot.checkout}.from(false).to(true)
				end
			end

		
			it "does not set checkout to true if precheckout was less than 5 minutes ago" do
				spot.precheckout = true
				Timecop.travel(2*60) do
					expect{spot.timelapsed_checkout}.to_not change{spot.checkout}
				end
			end

			it "destroys a spot if user checked out 2 minutes ago" do
				spot.checkout = true
				Timecop.travel(2*60) do
					expect{spot.destroy_spot}.to change{Spot.count}
				end
			end

			it "does not destroy a spot if user checked out less than 2 minutes ago" do
				spot.checkout = true
				Timecop.travel(60) do
				expect{spot.destroy_spot}.to change{Spot.count}.by(0)
				end
			end

			it "awards 2 points to user if user prechecks out" do
				spot.precheckout = true
				expect{spot.points_awarded}.to change{spot.user.points}.by(2)
			end

			it "awards 1 points to user if user checksout" do
				spot.checkout = true
				expect{spot.points_awarded}.to change{spot.user.points}.by(1)
			end
		end

  end

end
