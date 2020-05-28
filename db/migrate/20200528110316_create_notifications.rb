class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :item_id
      t.integer :comment_id
      t.integer :like_id
      t.string :action

      t.timestamps
    end
  end
end
