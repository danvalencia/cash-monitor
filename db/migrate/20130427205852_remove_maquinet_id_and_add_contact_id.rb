class RemoveMaquinetIdAndAddContactId < ActiveRecord::Migration
  def self.up
  	remove_column :contacts, :maquinet_id
    add_column :maquinets, :contact_id, :integer
  end

  def self.down
  	remove_column :maquinets, :contact_id
    add_column :contacts, :maquinet_id, :integer
  end

end
