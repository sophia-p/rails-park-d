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

  # describe "spot methods" do
  # end

end
