class SpotsController < ApplicationController

  # def index
  #   Spot.spot_refresh
  #   @spots = Spot.available_spots
  #   render json: {:spots => @spots}
  # end

  def index
    Spot.spot_refresh

    @local_spots = Spot.spots_in_range(lat: params[:lat].to_f, lng: params[:lng].to_f, user_id: current_user.id)

    render json: {:spots => @local_spots}
  end

  def show
    @spot = Spot.find_by(params[:lat, :lng])
  end

  def new
    @spot = Spot.new
  end

  def create
    if Spot.on_existing_spot(spot_params)
      @old_spot = Spot.on_existing_spot(spot_params)
      if @old_spot.user != current_user
        @old_spot.points_awarded
      end
      @old_spot.destroy
    end
    @spot = Spot.new(spot_params)
    if Spot.where(user_id: current_user.id, precheckout: false, checkout: false).length == 0
      @spot.save
      render partial: "precheckout-checkout"
    else
      flash[:already_checkedin] = "You are already checked into a spot"
    end
  end

  def edit
    @spot = Spot.find_by(params[:lat, :lng])
  end

  def update
    @spot = Spot.find_by(user_id: current_user.id)
    @spot.update(spot_params)
    render partial: "check_in-spot_taken"
  end

  def destroy
    if Spot.find_by(spot_params)
      Spot.find_by(spot_params).destroy
      render json: {notice: "Sorry that spot was taken. Let's find you another spot."}
    else
      render json: {notice: "We don't have a spot listed there."}
    end

  end


  private
  def spot_params
    params.require(:spot).permit(:user_id, :lat, :lng, :precheckout, :checkout)
  end
end
