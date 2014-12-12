class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,             :null => false
      t.string :email,                :null => false
      t.string :encrypted_password,   :null => false
      t.string :password_salt,        :null => false
      t.string :persistence_token,    :null => false

      # Magic columns, free data!
      t.integer :login_count,         :null => false, :default => 0
      t.integer :failed_login_count,  :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.integer :current_login_ip
      t.integer :last_login_ip

      t.timestamps
    end

    add_index :users, :username, :unique => true
    add_index :users, :persistence_token
    add_index :users, :last_request_at
  end
end
