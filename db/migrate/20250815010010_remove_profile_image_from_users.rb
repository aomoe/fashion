class RemoveProfileImageFromUsers < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :profile_image, :string
  end
end
