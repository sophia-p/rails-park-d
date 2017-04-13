require 'rails_helper'

RSpec.describe SpotsController, type: :controller do
	let(:spot) {FactoryGirl.create(:spot)}
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
	    it 'returns JSON' do
	  		get :index
  			expect(response.content_type).to eq("text/html")
		end 
  	end


	describe "GET#show" do
		context "user is not signed in" do
	  		it "redirects to sign in" do
		  		get :show, params: {id: spot.id}
		  		expect(response).to redirect_to(new_user_session_path)
			end
		end
	end
	describe "GET#new" do
		context "user is not signed in" do
	  		it "redirects to sign in" do
		  		get :new
		  		expect(response).to redirect_to(new_user_session_path)
			end
		end
	end	

	describe "GET#create" do
		context "user is not signed in" do
	  		it "redirects to sign in" do
		  		get :new
		  		expect(response).to redirect_to(new_user_session_path)
			end
		end
	end




end
