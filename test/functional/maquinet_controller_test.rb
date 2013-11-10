require 'test_helper'

class MaquinetsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:admin]
    sign_in users(:admin)
    @maquinet_one = machines(:one)
    @maquinet_two = machines(:two)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get show" do
    get :show, :id => @maquinet_one.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @maquinet_one.id
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  # test "should get create" do
  #   get :create 
  #   assert_response :success
  # end

  # test "should get update" do
  #   get :update, :id => @maquinet_one.id
  #   assert_response :success
  # end

end
