class AddPasswordDigestToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string
    add_column :owners, :password_digest, :string
    remove_column :users, :password, :string
    remove_column :owners, :password, :string
  end
end
