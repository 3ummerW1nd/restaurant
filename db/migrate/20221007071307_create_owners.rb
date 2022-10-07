class CreateOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :owners do |t|
      t.date :birthday
      t.boolean :gender
      t.string :name
      t.string :password
      t.string :image
      t.string :phone
      t.string :email
      t.timestamps
    end
  end
end
