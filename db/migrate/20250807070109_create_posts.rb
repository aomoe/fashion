class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :body
      t.string :post_image, null: false
      t.string :original_image_url
      t.string :adjusted_image_url
      t.integer :brightness_level, default: 0

      t.timestamps
    end
  end
end
