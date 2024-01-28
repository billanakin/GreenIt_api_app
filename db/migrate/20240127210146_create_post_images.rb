class CreatePostImages < ActiveRecord::Migration[7.1]
  def change
    create_table :post_images do |t|
      t.references :post
      t.integer :rank

      t.timestamps
    end
  end
end
