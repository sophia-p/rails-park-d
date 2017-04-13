require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  	describe "GET #show" do

	    it "redirects when user is not signed in" do
	      get :show, params: {id: user.id}
	      expect(response).to have_http_status 302
	    end
	    it "redirects when user is not signed in" do
	    	get :show, params: {id: user.id}
	    	expect(response).to redirect_to(new_user_session_path)
	    end	 
  	end

  	describe "signed in user" do
  		let(:user) {FactoryGirl.create(:user)}
  		it "returns http success" do
	  		login_with user
	  		get :show, params: {id: user.id}
	  		expect(response).to render_template(:show)
		end
  		it "allows access to signed in user" do
	  		login_with user
	  		get :show, params: {id: user.id}
	  		expect(response).to have_http_status(:success)
	  	end
  	end

end
