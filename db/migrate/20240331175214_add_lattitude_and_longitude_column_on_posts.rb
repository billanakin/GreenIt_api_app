class AddLattitudeAndLongitudeColumnOnPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :latitude, :decimal, precision: 10, scale: 6
    add_column :posts, :longitude, :decimal, precision: 10, scale: 6
  end
end
