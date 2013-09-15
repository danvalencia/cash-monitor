class Machine < ActiveRecord::Base
  attr_accessible :coin_time, :coin_value, :location, :name, :user_id, :contact_id, :machine_uuid
  belongs_to :user
  belongs_to :contact
  has_many :sessions
  has_many :statuses
  validates :coin_time, :presence => true, :allow_blank => false, :uniqueness => false
  validates :coin_value, :presence => true, :allow_blank => false, :uniqueness => false
  validates :name, :presence => true, :allow_blank => false, :uniqueness => false
  validates :machine_uuid, :presence => true, :allow_blank => false, :uniqueness => true
end
