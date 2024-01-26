class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user

      t.string :title
      t.text   :body
      t.point  :geo_location

      t.timestamps
    end
  end
end
