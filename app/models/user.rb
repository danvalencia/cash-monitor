class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :phone_number, :username
  has_many :maquinets
  validates :email, :presence => true, :allow_blank => false, :uniqueness => true
  validates :first_name, :presence => true, :allow_blank => false, :uniqueness => false
  validates :last_name, :presence => true, :allow_blank => false, :uniqueness => false
  validates :password, :presence => true, :allow_blank => false, :uniqueness => false
  validates :phone_number, :presence => true, :allow_blank => false, :uniqueness => false
  validates :username, :presence => true, :allow_blank => false, :uniqueness => true
end
