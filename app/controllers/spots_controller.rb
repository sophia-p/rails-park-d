class SpotsController < ApplicationController
  def show
    @spot = Spot.find_by(params[:lat, :long])
  end

  def destroy
    @spot = Spot.find_by(params[:lat, :long])
    if @spot.precheckout
      @spot.user.precheckout_point
    else
      @spot.user.checkout_point
    end
    @spot.destroy
    redirect_to spots_create
  end

  def new
    @spot = Spot.new
  end

  def create
    @spot = Spot.new(spot_params)

    @spot.save
    redirect_to @spot
  end

  def edit
    @spot = Spot.find_by(params[:lat, :long])
  end



  private
  def spot_params
    params.require(:spot).permit(:user_id, :lat, :long, :precheckout, :checkout)
  end
end
