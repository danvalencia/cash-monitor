class RemoveMaquinetIdAndAddContactId < ActiveRecord::Migration
  def change
  	remove_column :contacts, :maquinet_id
    add_column :maquinets, :contact_id, :integer
  end
end
