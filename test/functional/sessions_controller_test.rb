require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  def setup
  end

  test "should get new_coin" do
    get :update
    assert_response :success
  end

end
