class SeedDefaultCategoriesAgain < ActiveRecord::Migration[7.2]
  DEFAULT_CATEGORY_NAMES = %w[トップス パンツ デニム スカート ワンピース アウター シューズ バッグ アクセサリー 小物].freeze

  def up
    DEFAULT_CATEGORY_NAMES.each do |name|
      Category.find_or_create_by!(name: name)
    end
  end

  def down
    Category.where(name: DEFAULT_CATEGORY_NAMES).delete_all
  end
end


