class Machine < ActiveRecord::Base
  attr_accessible :coin_time, :coin_value, :location, :name, :machine_uuid, :contact_name, :contact_phone_number, :contact_email
  belongs_to :user
  has_many :sessions
  has_many :statuses
  validates :coin_time, presence: true, allow_blank: false
  validates :coin_value, presence: true, allow_blank: false
  validates :name, presence: true, allow_blank: false
  validates :machine_uuid, presence: true, allow_blank: false, uniqueness: true
  validates :contact_phone_number, numericality: { only_integer: true }

  validates_format_of :contact_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create

  before_validation :generate_uuid, on: :create

  scope :with_user, ->(user) { where("user_id = ?", user.id)}

  def generate_uuid
	  new_uuid = SecureRandom.uuid
    self.machine_uuid = new_uuid
  end

end
