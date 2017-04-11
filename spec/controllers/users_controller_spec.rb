require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	let!(:user) {User.create!(username:"johndoe",email:"johndoe@email.com", password:"123456")}
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

end
