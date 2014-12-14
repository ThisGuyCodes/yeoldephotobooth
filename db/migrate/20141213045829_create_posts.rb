class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :user, null: false, index: true

      t.timestamps
    end

    add_index :posts, :created_at
  end
end
