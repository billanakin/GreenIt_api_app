class CreateFollows < ActiveRecord::Migration[7.1]
  def change
    create_table :follows do |t|
      t.references :from_user
      t.references :to_user

      t.timestamps
    end
    add_index :follows, [:from_user_id, :to_user_id], unique: true
  end
end
