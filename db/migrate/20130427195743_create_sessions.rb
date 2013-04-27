class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :maquinet_id
      t.integer :coin_count
      t.integer :coin_value
      t.integer :coin_time
      t.integer :print_count
      t.integer :print_time
      t.integer :call_count
      t.integer :call_value
      t.integer :call_time
      t.timestamp :start_time
      t.timestamp :end_time

      t.timestamps
    end
  end
end
