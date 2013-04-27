class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :maquinet_id
      t.timestamp :start_ping
      t.timestamp :last_ping

      t.timestamps
    end
  end
end
