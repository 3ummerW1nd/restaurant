class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :restaurant_id
      t.integer :user_id
      t.string :comment
      t.boolean :tasted
      t.string :headcount
      t.integer :price
      t.boolean :anonymous
      t.integer :upvote
      t.string :image
      t.timestamps
    end
  end
end
