class AddStyleCategoryToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :style_category, :integer
  end
end
