class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  validates :title, length: { maximum: 255 } ,presence: true
  validates :brightness_level, inclusion: { in: 0..100 }

  has_one_attached :image
end
