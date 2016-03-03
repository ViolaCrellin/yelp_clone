class AddReviewedRestaurantsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :reviews, :polymorphic => true
    end
  end

end
