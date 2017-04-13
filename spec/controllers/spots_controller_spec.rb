require 'rails_helper'

RSpec.describe SpotsController, type: :controller do
	let(:user) {FactoryGirl.create(:user)}
  	describe "GET #index" do
	    it "redirects when user is not signed in" do
	      get :index
	      expect(response).to have_http_status 302
	    end
	    it "redirects when user is not signed in" do
	    	get :index
	    	expect(response).to redirect_to(new_user_session_path)
	    end	 
  	end

  	describe "signed in user" do
  		before(:each) do 
  			login_with user(FactoryGirl.create(:user, username:"janedoe", email:"janedoe@email.com"))
  		end
  	it "returns http success" do
  			FactoryGirl.create_list(:spot, 5)
	  		# login_with user
	  		get :index, format: :json
	  		parse_json = JSON.parse(response.body)
	  		expect(parse_json["spots"]).to_not be_nil
		end
  		it "allows access to signed in user" do
	  		# login_with user
	  		get :index, format: :json
	  		expect(response).to have_http_status(:success)
	  	end
  	end

end
