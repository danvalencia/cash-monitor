class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_column :users, :email, :string, :null => false, :default => ""


    change_table(:users) do |t|

      t.remove :username
      t.remove :password

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""
      t.string :password_salt

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down

    change_column :users, :email, :string, :null => true

    change_table(:users) do |t|
      t.string :username
      t.string :password

      t.remove :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, 
               :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip

      t.remove_index :email
    end



  end
end
