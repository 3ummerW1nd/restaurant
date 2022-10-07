class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.integer :restaurant_id
      t.integer :price
      t.string :image
      t.integer :upvote
      t.timestamps
    end
  end
end
