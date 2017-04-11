class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		@user = User.find_by(id: params[:id])
		if require_owner
			@user
		else
			redirect_to root_path
		end	
	end

	private
	def require_owner
		return true if current_user.id == @user.id
	end
end
