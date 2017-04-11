class SpotsController < ApplicationController
  def show
    @
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
    @spot = Spot.find
  end

  def destroy

  end

  private
  def spot_params
    params.require(:spot).permit(:user_id, :lat, :long, :precheckout, :checkout)
  end
end
