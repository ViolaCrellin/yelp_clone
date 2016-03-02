class ReviewsController < ApplicationController
	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@review = Review.new
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@restaurant.reviews.build_with_user(review_params, current_user)
		@restaurant.reviews.create(review_params)
		redirect_to restaurants_path
	end

	def review_params
		params.require(:review).permit(:thoughts, :rating).merge(user: current_user)
	end

	# def destroy
	# 	@review = Review.find(params[:id])
	# 	@review.user
	# 	@review.destroy
	# 	flash[:notice] = 'Review deleted successfully'
	# 	redirect_to "/restaurants"
	# end
end
