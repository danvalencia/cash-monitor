class Maquinet < ActiveRecord::Base
  attr_accessible :coin_time, :coin_value, :location, :name, :user_id, :contact_id
  belongs_to :user
  belongs_to :contact
  has_many :sessions
  has_many :statuses
  validates :coin_time, :presence => true, :allow_blank => false, :uniqueness => false
  validates :coin_value, :presence => true, :allow_blank => false, :uniqueness => false
  validates :location, :presence => false, :allow_blank => true, :uniqueness => false
  validates :name, :presence => true, :allow_blank => false, :uniqueness => false
  validates :contact_id, :presence => true, :allow_blank => false, :uniqueness => false
end
