class CreateReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :replies do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :reply_id
      t.string :reply
      t.timestamps
    end
  end
end
