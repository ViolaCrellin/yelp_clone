class EndorsementsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    render json: {new_endorsement_count: @review.endorsements.count}
  end

  def endorsement_params
    params.require(:review).permit(:id)
  end


end
