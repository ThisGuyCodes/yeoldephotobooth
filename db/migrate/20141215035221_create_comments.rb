class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, index: true, null: false
      t.references :user, index: true, null: false
      t.text :body

      t.timestamps
    end

    add_index :comments, :created_at
  end
end
