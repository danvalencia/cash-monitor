class RemoveContactIdFromMachines < ActiveRecord::Migration
  def up
    change_table(:machines) do |t|
	    t.remove :contact_id

	    t.string :contact_name, default: ""
	    t.string :contact_phone_number, default: ""
	    t.string :contact_email, default: ""
	end
  end

  def down
    add_column :contact_id, type: :string

    t.remove :contact_name
    t.remove :contact_phone_number
    t.remove :contact_email
  end
end
