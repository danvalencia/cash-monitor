require 'test_helper'
require 'mocha/setup'

class Api::V1::SessionsControllerTest < ActionController::TestCase

  def setup
    @valid_machine = machines(:one)
    @new_session_uuid = SecureRandom.uuid

    @second_machine = machines(:two)
    @existing_session = sessions(:one)
  end

  test "should return 201 with when machine id exists and sessions is new" do
    post :create, machine_uuid: @valid_machine.machine_uuid, session_uuid: @new_session_uuid, session_created_at: "2013-11-13 15:02:45", format: :json
    assert_response :success
    assert_equal 201, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response
    new_session = Session.where(session_uuid: @new_session_uuid).first
    assert_equal 1, new_session.coin_count
    assert_equal 11, new_session.session_created_at.month
    assert_equal 13, new_session.session_created_at.day
    assert_equal 2013, new_session.session_created_at.year
  end

  test "should return 400 when doing POST (create method) on an existing session ID" do
    post :create, machine_uuid: @second_machine.machine_uuid, session_uuid: @existing_session.session_uuid, format: :json
    assert_equal 400, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response
  end

  test "should return 400 when session_created_at param not present" do
    post :create, machine_uuid: @second_machine.machine_uuid, session_uuid: @new_session_uuid, format: :json
    assert_equal 400, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response
  end

  test "should return 500 when internal error occurs on new session" do
    my_machine = Machine.new do |m|
      m.machine_uuid = "8ddca8b3-6bf8-4cbc-8965-6255b0169cdb"
    end
    my_session = Session.new do |s|
      s.session_uuid = "13d6058b-feb8-4767-a85c-bc616d1835ca"
      s.coin_count = 1
    end

    machines_result_set = [ my_machine ] 
    Machine.expects(:where).with(machine_uuid: my_machine.machine_uuid).returns(machines_result_set)

    sessions_result_set = []
    Session.expects(:where).with(session_uuid: my_session.session_uuid).returns(sessions_result_set)
    Session.expects(:new).returns(my_session)
    my_session.expects(:save).returns(false)

    post :create, machine_uuid: my_machine.machine_uuid, session_uuid: my_session.session_uuid, session_created_at: "2013-11-13 15:02:45", format: :json
    assert_response :error
    assert_equal 500, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response
  end

  test "should return 200 when session exists and should update coin_count according to query parameters" do
    # Initially, existing session has a coin count of 1
    assert_equal 1, @existing_session.coin_count
    put :update, machine_uuid: @second_machine.machine_uuid, session_uuid: @existing_session.session_uuid, coin_count: 3, format: :json
    assert_response :success
    assert_equal 200, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response

    assert_equal 3, Session.where(session_uuid: @existing_session.session_uuid).first.coin_count
  end

  # test "should close session if close_session parameter is in the request" do
  #   put :update, machine_uuid: @second_machine.machine_uuid, session_uuid: @existing_session.session_uuid, close_session: true, format: :json
  #   assert_response :success
  #   assert_equal 200, @response.code.to_i
  #   json_response = JSON.parse @response.body
  #   assert_not_nil json_response

  #   assert_not_nil Session.where(session_uuid: @existing_session.session_uuid).first.closed_at
  # end

  test "should return 400 when session does not exist on update" do
    # Initially, existing session has a coin count of 1
    assert_equal 1, @existing_session.coin_count

    put :update, machine_uuid: @second_machine.machine_uuid, session_uuid: @new_session_uuid, format: :json
    assert_equal 400, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response

  end

  test "should return 400 when coin_count is not present in request and session exists" do
    put :update, machine_uuid: @second_machine.machine_uuid, session_uuid: @existing_session.session_uuid, format: :json
    assert_equal 400, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response

    # Session coin count was not modified
    assert_equal 1, Session.where(session_uuid: @existing_session.session_uuid).first.coin_count

  end

  test "should return 404 when machine uuid does not exist" do
    post :update, machine_uuid: "fakeuuid", session_uuid: @existing_session.session_uuid, format: :json
    assert_response :missing
    assert_equal 404, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response
  end

  test "should return 500 when internal error occurs on existing session" do

    my_machine = Machine.new do |m|
      m.machine_uuid = "8ddca8b3-6bf8-4cbc-8965-6255b0169cdb"
    end
    my_session = Session.new do |s|
      s.session_uuid = "13d6058b-feb8-4767-a85c-bc616d1835ca"
      s.coin_count = 1
    end

    machines_result_set = [ my_machine ] 
    Machine.expects(:where).with(machine_uuid: my_machine.machine_uuid).returns(machines_result_set)

    sessions_result_set = [ my_session ]
    Session.expects(:where).with(session_uuid: my_session.session_uuid).returns(sessions_result_set)
    my_session.expects(:save).returns(false)

    put :update, machine_uuid: my_machine.machine_uuid, session_uuid: my_session.session_uuid, coin_count: 3, format: :json
    assert_response :error
    assert_equal 500, @response.code.to_i
    json_response = JSON.parse @response.body
    assert_not_nil json_response
  end




end
