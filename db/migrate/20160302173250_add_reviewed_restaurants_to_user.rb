class AddReviewedRestaurantsToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :reviews, :polymorphic => true
    end
  end

  # def down
  #   change_table :products do |t|
  #     t.remove_references :imageable, :polymorphic => true
  #   end
  # end

end
