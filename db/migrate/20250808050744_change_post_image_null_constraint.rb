class ChangePostImageNullConstraint < ActiveRecord::Migration[7.2]
  def change
    change_column_null :posts, :post_image, true
  end
end
