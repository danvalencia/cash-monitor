class Status < ActiveRecord::Base
  attr_accessible :last_ping, :machine_id, :start_ping
  belongs_to :machine
  validates :last_ping, :presence => true, :allow_blank => false
  validates :machine_id, :presence => true, :allow_blank => false
  validates :start_ping, :presence => true, :allow_blank => false
end