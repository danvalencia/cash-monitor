require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new_coin" do
    get :new_coin
    assert_response :success
  end

end
