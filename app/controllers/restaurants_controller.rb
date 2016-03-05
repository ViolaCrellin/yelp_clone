class RestaurantsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show, :create]

  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def restaurant_params
  	params.require(:restaurant).permit(:name, :image)
  end

  def create
  	@restaurant = Restaurant.create(restaurant_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to '/restaurants'
    else
      render 'new'
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user_id == current_user.id
      @restaurant.update(restaurant_params)
      flash[:notice] = 'Restaurant edited successfully'
    else
      flash[:notice] = 'You can only edit your own restaurants'
    end
    redirect_to "/restaurants"
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.user_id == current_user.id
      @restaurant.destroy
      flash[:notice] = 'Restaurant deleted successfully'
    else
      flash[:notice] = 'You can only delete your own restaurant'
    end
    redirect_to "/restaurants"
  end
end
