class SpotsController < ApplicationController
  def index
    @spots = Spot.all
  end

  def show
    @spot = Spot.find_by(params[:lat, :lng])
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)

    @spot.save
  end

  def edit
    @spot = Spot.find_by(params[:lat, :lng])
  end

  def destroy
    if Spot.find_by(params[:lat, :lng])
      @spot = Spot.find_by(params[:lat, :lng])
      if @spot.precheckout
        @spot.user.precheckout_point
      else
        @spot.user.checkout_point
      end
      @spot.destroy
    end
      redirect_to spots_create
  end


  private
  def spot_params
    params.require(:spot).permit(:user_id, :lat, :lng)
  end
end
