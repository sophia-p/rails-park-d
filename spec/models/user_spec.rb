require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) {FactoryGirl.create(:user)}
	let(:spot) {FactoryGirl.create(:spot)}

	describe "validations" do
		# let (:user_with_username) {User.new(username:"johndoe", email:"johndoe@email.com", password: "123456")}
		let (:user_without_username) {FactoryGirl.build(:user, username:"", password:"123456")}

	 
			it "is not valid when username is blank" do
				user_without_username.valid?
				expect(user_without_username.errors[:username]).to_not be_empty
			end

			it "is valid when user has username" do
				user.valid?
				expect(user.errors[:username]).to be_empty
			end

			it "has default points" do
				expect(user.points). to eq 10
			end

			it "has a unique username" do
				first_user = user
				second_user = User.new(username:"johndoe", email:"john@doe.com", password: "123456")
				expect{second_user.save!}.to raise_error(ActiveRecord::RecordInvalid)
			end
	end
	describe "methods" do
		context "returns the tier object based on points" do
			it "returns Rookie if user has 25 points or fewer" do
				expect(user.tier).to eq ({name: "Rookie", spots: 2, radius: 0.0034})				
			end
		end
		context "checkout points" do
			it "awards user 2 points" do
				expect{user.precheckout_point}.to change{user.points}.by(2)
			end

			it "awards user 1 point" do
				expect{user.checkout_point}.to change{user.points}.by(1)
			end
		end
		# context "checkin/checkout methods" do
		# 	it "returns array of spots after user has checked out of spot" do
		# 		# spot.update(checkout: true)
				
		# 		expect(user.activate_spots).to include([spot])
		# 	end
		# end


	end


end
