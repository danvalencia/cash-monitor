class User < ActiveRecord::Base
  has_many :machines
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :phone_number, :admin

  validates :email, :presence => true, :allow_blank => false, :uniqueness => true
  validates :first_name, :presence => true, :allow_blank => false
  validates :last_name, :presence => true, :allow_blank => false
  validates :phone_number, :presence => true, :allow_blank => false
end
