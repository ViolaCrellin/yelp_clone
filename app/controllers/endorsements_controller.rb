class EndorsementsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    @review.endorsements.create
    redirect_to '/restaurants'
  end

  def endorsement_params
    params.require(:review).permit(:id)
  end


end
