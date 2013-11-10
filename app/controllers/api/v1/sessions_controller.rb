class Api::V1::SessionsController < ApplicationController

	def update
		session_uuid = params[:session_uuid]
		machine_uuid = params[:machine_uuid]
		machine = Machine.where(machine_uuid: machine_uuid).first
		unless machine.nil?
			@machine_session = Session.where(session_uuid: session_uuid).first
			if @machine_session.nil?
				@machine_session = Session.new	do |s|
					s.session_uuid = session_uuid
					s.machine = machine
					s.coin_count = 1
				end
				respond_to do |format|
					if @machine_session.save!
						format.json {
							render json: {message: 'Session Created'}, status: 201
						} 
					end
				end
			end
		end
	end
end
