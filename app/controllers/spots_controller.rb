class SpotsController < ApplicationController

  # def index
  #   Spot.spot_refresh
  #   @spots = Spot.available_spots
  #   render json: {:spots => @spots}
  # end

  def index
    Spot.spot_refresh
    @user = current_user
    if @user.current_destination
      @local_spots = Spot.spots_in_range(lat: @user.current_destination.des_lat, lng: @user.current_destination.des_lng)
    else
      @local_spots = Spot.spots_in_range(lat: params[:lat].to_i, lng: params[:lng].to_i)
    end
    render json: {:spots => @local_spots}
  end

  def show
    @spot = Spot.find_by(params[:lat, :lng])
  end

  def new
    @spot = Spot.new
  end

  def create
    @old_spot = Spot.on_existing_spot(spot_params)
    @old_spot.points_awarded
    @old_spot.destroy
    @spot = Spot.new(spot_params)
    if Spot.where(user_id: current_user.id, precheckout: false, checkout: false).length == 0
      @spot.save
      redirect_to action: "index"
    else
      flash[:alert] = "You are already checked into a spot"
    end
  end

  def edit
    @spot = Spot.find_by(params[:lat, :lng])
  end

  def update
    @spot = Spot.find_by(user_id: current_user.id)
    @spot.update(spot_params)
    redirect_to "/"
  end

  def destroy
    @spot = Spot.find_by(spot_params)
    @spot.destroy
  end


  private
  def spot_params
    params.require(:spot).permit(:user_id, :lat, :lng, :precheckout, :checkout)
  end
end
