class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  has_many :endorsements, dependent: :destroy
  validates :rating, inclusion: (1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "You have already reviewed this restaurant" }

end
