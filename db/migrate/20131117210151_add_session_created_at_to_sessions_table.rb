class AddSessionCreatedAtToSessionsTable < ActiveRecord::Migration
  def change
  	add_column :sessions, :session_created_at, :datetime
  end
end
