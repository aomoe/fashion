class Post < ApplicationRecord
  belongs_to :user, dependent: :destroy
  validates :title, length: { maximum: 255 }
  validates :brightness_level, inclusion: { in: 0..100 }

  has_one_attached :image
end
