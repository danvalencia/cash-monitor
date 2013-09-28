class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me, :phone_number, :username

  has_many :machines
  validates :email, :presence => true, :allow_blank => false, :uniqueness => true
  validates :first_name, :presence => true, :allow_blank => false, :uniqueness => false
  validates :last_name, :presence => true, :allow_blank => false, :uniqueness => false
  validates :password, :presence => true, :allow_blank => false, :uniqueness => false
  validates :phone_number, :presence => true, :allow_blank => false, :uniqueness => false
  validates :username, :presence => true, :allow_blank => false, :uniqueness => true
end
