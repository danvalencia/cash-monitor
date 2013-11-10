class Api::V1::SessionsController < ApplicationController

	def update
		session_uuid = params[:session_uuid]
		machine_uuid = params[:machine_uuid]
		machine = Machine.where(machine_uuid: machine_uuid).first
		if machine.nil?
			respond_to do |format|
				format.json {
					render json: {message: 'Machine does not exist'}, status: 404 
				}	 
			end
		else
			@machine_session = Session.where(session_uuid: session_uuid).first
			puts "Found machine session: #{@machine_session}"
			if @machine_session.nil?
				@machine_session = Session.new	do |s|
					s.session_uuid = session_uuid
					s.machine = machine
					s.coin_count = 1
				end
				respond_to do |format|
					if @machine_session.save
						format.json {
							render json: {message: 'Session Created'}, status: 201
						} 
					end
				end
			else
				@machine_session.coin_count += 1
				respond_to do |format|
					if @machine_session.save
						format.json {
							render json: {message: 'Session Updated'}, status: 200
						}
					else
						format.json {
							render json: {message: 'Oops! seems like an internal error occured'}, status: 500
						}
					end
				end
			end

		end
	end
end
