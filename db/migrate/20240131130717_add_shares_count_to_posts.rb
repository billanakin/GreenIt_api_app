class AddSharesCountToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :shares_count, :integer, null: false, default: 0
  end
end
