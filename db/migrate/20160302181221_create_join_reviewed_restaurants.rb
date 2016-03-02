class CreateJoinReviewedRestaurants < ActiveRecord::Migration
  def change
    create_table :join_reviewed_restaurants do |t|
      t.integer :review_id
      t.integer :restaurant_id
    end
  end
end
