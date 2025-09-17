class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :likes, dependent: :destroy
  validates :title, length: { maximum: 255 } ,presence: true
  validates :brightness_level, inclusion: { in: 1..100 }

  has_one_attached :image
  has_one_attached :processed_image

  after_update :process_image_if_brightness_changed

  enum :style_category, User.style_categories
  enum :height_range, User.height_ranges

  def likes_count
    likes.count
  end

  def liked_by?(user)
    return false unless user
    likes.exists?(user: user)
  end

  def display_image_url
    if processed_image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(processed_image, only_path: true)
    elsif image.attached?
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    else
      nil
    end
  end

  private

  def process_image_if_brightness_changed
    if saved_change_to_brightness_level? && image.attached?
      process_image_with_brightness
    end
  end

  def process_image_with_brightness
    return unless image.attached?

    begin
      # ファイルがダウンロード可能かチェック
      return unless image.blob.present?

      temp_file = Tempfile.new(['original', File.extname(image.filename.to_s)])
      temp_file.binmode
      temp_file.write(image.download)
      temp_file.close

      processed_temp = Tempfile.new(['processed', '.jpg'])

      mini_image = MiniMagick::Image.open(temp_file.path)
      brightness_value = calculate_imagemagick_brightness
      mini_image.modulate("#{100 + brightness_value},100,100")
      mini_image.format('jpeg')
      mini_image.write(processed_temp.path)

      processed_image.attach(
        io: File.open(processed_temp.path),
        filename: "processed_#{image.filename}",
        content_type: image.content_type
      )

      temp_file.unlink
      processed_temp.unlink
    rescue => e
      Rails.logger.error "ImageMagick処理エラー: #{e.message}"
      # processed_imageを削除（存在する場合）
      processed_image.purge if processed_image.attached?
      # temp_fileのクリーンアップ
      temp_file&.unlink
      processed_temp&.unlink
    end
  end

  def calculate_imagemagick_brightness
    (brightness_level - 50)
  end
end
