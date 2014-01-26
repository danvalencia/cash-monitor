class Session < ActiveRecord::Base
  attr_accessible :call_count, :call_time, :call_value, :coin_count, :coin_time, :coin_value, :end_time, :machine_id, :print_count, :print_time, :start_time
  belongs_to :machine

  validates :machine_id, presence: true, allow_blank: false

  before_save :assign_coin_value

  def earnings
 	return coin_count * coin_value unless coin_count.nil? or coin_value.nil?
 	0
  end

  def assign_coin_value
  	self.coin_value = machine.coin_value
  end
end
