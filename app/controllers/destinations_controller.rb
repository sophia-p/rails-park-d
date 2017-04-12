class DestinationsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @destination = Destination.new
  end

  def create
    @user = current_user
    @destination = @user.destinations.new(destination_params)

    @destination.save
    render json: {:destination => @destination}
  end

  def edit
  end

  def destroy
  end

  private

  def destination_params
    params.require(:destination).permit(:user_id, :des_lat, :des_lng)
  end
end
