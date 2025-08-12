class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  validates :title, length: { maximum: 255 } ,presence: true
  validates :brightness_level, inclusion: { in: 0..100 }

  has_one_attached :image

  enum :style_category, User.style_categories
  enum :height_range, User.height_ranges

  def style_category_japanese
    case style_category
    when 'straight'
      'ストレート'
    when 'wave'
      'ウェーブ'
    when 'natural'
      'ナチュラル'
    else
      style_category.to_s
    end
  end

  def height_range_japanese
    case height_range
    when 'under_150'
      '150cm未満'
    when 'range_150_155'
      '150〜155cm'
    when 'range_155_160'
      '155〜160cm'
    when 'range_160_165'
      '160〜165cm'
    when 'range_165_170'
      '165〜170cm'
    when 'range_170_175'
      '170〜175cm'
    when 'range_175_180'
      '175〜180cm'
    when 'over_180'
      '180cm以上'
    else
      height_range.to_s
    end
  end
end
