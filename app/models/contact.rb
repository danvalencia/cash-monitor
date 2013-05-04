class Contact < ActiveRecord::Base
  attr_accessible :email, :name, :phone_number
  has_many :machines
  validates :email, :presence => true, :allow_blank => false, :uniqueness => false
  validates :name, :presence => true, :allow_blank => false, :uniqueness => false
  validates :phone_number, :presence => true, :allow_blank => false, :uniqueness => false
end
