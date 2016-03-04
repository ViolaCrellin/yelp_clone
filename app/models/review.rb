class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements
  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "You have already reviewed this restaurant" }

  # def reviewee(id)
  #   @user = User.where(reviews_id: id)
  #   require 'pry'; binding.pry
  #   @user
  # end
end
