require 'test_helper'

class SessionTest < ActiveSupport::TestCase

  test "should give you total earnings" do
  	mi_maquinet = machines(:one)

		machine_session = Session.new	do |s|
			s.session_uuid = "017d9c84-4f60-4113-82cf-febdaaadd789"
			s.machine = mi_maquinet
			s.start_time = DateTime.parse "2013-11-13 15:02:45" 
			s.coin_count = 1
		end
		machine_session.save!

		assert_equal 5, mi_maquinet.coin_value 
		machine_session.coin_count += 1

  	assert_equal 10, machine_session.earnings
  end
end
