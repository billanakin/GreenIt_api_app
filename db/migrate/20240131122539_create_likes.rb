class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :user
      t.references :post

      t.timestamps
    end
    add_index :likes, [:user_id, :post_id], unique: true
  end
end
