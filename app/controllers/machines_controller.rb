class MachinesController < ApplicationController
  before_filter :authenticate_user!

  def earnings  
    machine_uuid = params[:machine_uuid]
    machine = Machine.where(machine_uuid: machine_uuid).first
    if machine.nil?
      response_message = { message: "Machine #{machine_uuid} does not exist"}
      response_status = 404
    else
      sessions = machine.sessions
      earnings = sessions.map do |s| 
        unless s.start_time.nil?  
          {x: s.start_time.to_formatted_s(:db), y: s.earnings}
        end
      end
      response_message = earnings.select{|s| !s.nil?}.to_json
      response_status = 200
    end
    render json: response_message, status: response_status

  end
end
