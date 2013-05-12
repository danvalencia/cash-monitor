class Session < ActiveRecord::Base
  attr_accessible :call_count, :call_time, :call_value, :coin_count, :coin_time, :coin_value, :end_time, :machine_id, :print_count, :print_time, :start_time
  belongs_to :machine
end
