class AddHeightRangeToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :height_range, :integer
  end
end
