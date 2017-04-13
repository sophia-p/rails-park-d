require 'rails_helper'

RSpec.describe HomeController, type: :controller do
	describe "guest access" do
  		describe "GET #index" do
    		it "requires login" do
      			get :index
      			expect(response).to redirect_to new_user_session_path
    		end
  		end
  	end

  	describe "signed in user" do
  		it "returns http success" do
	  		login_with FactoryGirl.create(:user)
	  		get :index
	  		expect(response).to render_template(:index)
	  	end
  		it "allows access to signed in user" do
	  		login_with FactoryGirl.create(:user)
	  		get :index
	  		expect(response).to have_http_status(:success)
	  	end
  	end
end
