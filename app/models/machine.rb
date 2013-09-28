class Machine < ActiveRecord::Base
  attr_accessible :coin_time, :coin_value, :location, :name, :user_id, :contact_id, :machine_uuid
  belongs_to :user
  belongs_to :contact
  has_many :sessions
  has_many :statuses
  validates :coin_time, :presence => true, :allow_blank => false
  validates :coin_value, :presence => true, :allow_blank => false
  validates :name, :presence => true, :allow_blank => false
  validates :machine_uuid, :presence => true, :allow_blank => false, :uniqueness => true

  before_create :generate_uuid

  def generate_uuid
  	begin
  	  new_uuid = SecureRandom.uuid
  	  m = Machine.find(:first, :conditions => ["machine_uuid = ?", new_uuid])
  	end while m != nil
  		
    self.machine_uuid = new_uuid
  end

end
