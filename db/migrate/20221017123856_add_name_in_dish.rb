class AddNameInDish < ActiveRecord::Migration[7.0]
  def change
    add_column :dishes, :name, :string
  end
end
