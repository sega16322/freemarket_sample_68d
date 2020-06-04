class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :from, foreign_key: { to_table: :users }, null: false
      t.references :to, foreign_key: { to_table: :users }, null: false
      t.references :room, foreign_key: { to_table: :items }, null: false
      t.text :message, null: false
      t.timestamps
    end
  end
end
