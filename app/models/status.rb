class Status < ActiveRecord::Base
  attr_accessible :last_ping, :maquinet_id, :start_ping
  belongs_to :maquinet
  validates :last_ping, :presence => true, :allow_blank => false, :uniqueness => false
  validates :maquinet_id, :presence => true, :allow_blank => false, :uniqueness => false
  validates :start_ping, :presence => true, :allow_blank => false, :uniqueness => false
end