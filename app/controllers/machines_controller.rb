class MachinesController < ApplicationController
  before_filter :authenticate_user!

  def earnings  
    machine_uuid = params[:machine_uuid]
    group_by = params[:group_by].to_sym
    machine = Machine.where(machine_uuid: machine_uuid).first
    if machine.nil?
      response_message = { message: "Machine #{machine_uuid} does not exist"}
      response_status = 404
    else
      machine_earnings = machine.earnings_by group_by
      response_status = 200
    end
    render json: machine_earnings, status: response_status

  end
end
