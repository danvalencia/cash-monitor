class CreateMaquinets < ActiveRecord::Migration
  def change
    create_table :maquinets do |t|
      t.integer :user_id
      t.string :name
      t.integer :coin_value
      t.integer :coin_time
      t.string :location

      t.timestamps
    end
  end
end
