class CreateUuids < ActiveRecord::Migration
  def change
  	add_column :maquinets, :machine_uuid, :string
  	add_column :sessions, :session_uuid, :string
  end
end
