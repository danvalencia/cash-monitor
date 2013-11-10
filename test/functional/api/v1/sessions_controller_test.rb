require 'test_helper'

class Api::V1::SessionsControllerTest < ActionController::TestCase

  def setup
    @valid_machine = machines(:one)
    @new_session_uuid = SecureRandom.uuid
  end

  test "should return 201 with when machine id exists and sessions is new" do
    post :update, machine_uuid: @valid_machine.machine_uuid, session_uuid: @new_session_uuid, format: :json
    puts "Response code: #{@response.code}"
    assert_response :success
    assert_equal 201, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response
  end

end
