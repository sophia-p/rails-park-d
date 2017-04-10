class SpotsController < ApplicationController
  def new
  end

  def create
    @spot = Spot.new(spot_params)

    @spot.save
    redirect_to @spot
  end

  private
  def spot_params
    params.require(:spot).permit(:user_id, :lat, :long, :precheckout, :checkout)
  end
end
