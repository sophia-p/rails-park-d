require 'rails_helper'

RSpec.describe User, type: :model do
	describe "validations" do
		let (:user_with_username) {User.new(username:"johndoe", email:"johndoe@email.com", password: "123456")}
		let (:user_without_username) {User.new(username:"", email:"johndoe@email.com", password: "123456")}

	 
			it "is not valid when username is blank" do
				user_without_username.valid?
				expect(user_without_username.errors[:username]).to_not be_empty
			end

			it "is valid when user has username" do
				user_with_username.valid?
				expect(user_with_username.errors[:username]).to be_empty
			end

			it "has default points" do
				expect(user_with_username.points). to eq 10
			end

			it "has a unique username" do
				first_user = user_with_username.save!
				second_user = User.new(username:"johndoe", email:"john@doe.com", password: "123456")
				expect{second_user.save!}.to raise_error(ActiveRecord::RecordInvalid)
			end
	end


end
