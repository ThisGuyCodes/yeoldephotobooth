class AddImageUrlToPost < ActiveRecord::Migration
  def change
    add_column :posts, :image_key, :string
  end
end
