class Post < ApplicationRecord
  belongs_to :user
  validates :title, length: { maximum: 255 }
  validates :post_image, presence: true
  validates :brightness_level, inclusion: { in: 0..100 }

  has_one_attached :image
end
