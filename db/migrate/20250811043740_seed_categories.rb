class SeedCategories < ActiveRecord::Migration[7.2]
  def up
    %W[トップス パンツ デニム スカート ワンピース アウター シューズ バッグ アクセサリー 小物].each { |name| Category.find_or_create_by!(name: name) }
  end

  def down
    Category.where(name: %w[トップス パンツ デニム スカート ワンピース アウター シューズ バッグ アクセサリー 小物]).delete_all
  end
end
