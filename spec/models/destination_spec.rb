require 'rails_helper'

RSpec.describe Destination, type: :model do
	describe "validations" do
		let(:dest_without_lat) {Destination.new(des_lng: 56.7878)}
		let(:dest_without_lng) {Destination.new(des_lat: 76.5656)}
		it "must have latitude" do
			dest_without_lat.valid?
			expect(dest_without_lat.errors[:des_lat]).to_not be_empty
		end
		it "must have latitude" do
			dest_without_lat.valid?
			expect(dest_without_lat.errors[:des_lat]).to_not be_empty
		end
	end
end
