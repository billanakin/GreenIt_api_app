class CreateShares < ActiveRecord::Migration[7.1]
  def change
    create_table :shares do |t|
      t.references :user
      t.references :post

      t.timestamps
    end
    add_index :shares, [:user_id, :post_id], unique: true
  end
end
