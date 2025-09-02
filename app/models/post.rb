class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :likes, dependent: :destroy
  validates :title, length: { maximum: 255 } ,presence: true
  validates :brightness_level, inclusion: { in: 0..100 }

  has_one_attached :image

  enum :style_category, User.style_categories
  enum :height_range, User.height_ranges

  def likes_count
    likes.count
  end

  def liked_by?(user)
    return false unless user
    likes.exists?(user: user)
  end
end
