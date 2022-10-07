class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :intro
      t.string :address
      t.integer :upvote
      t.integer :owner_id
      t.timestamps
    end
  end
end
