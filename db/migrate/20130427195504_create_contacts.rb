class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :maquinet_id
      t.string :name
      t.string :phone_number
      t.string :email

      t.timestamps
    end
  end
end