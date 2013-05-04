class ChangeMaquinetsToMachinesTable < ActiveRecord::Migration
  def change
  	rename_table :maquinets, :machines
  	rename_column :sessions, :maquinet_id, :machine_id
  	rename_column :statuses, :maquinet_id, :machine_id
  end
end
