class Api::V1::SessionsController < ApplicationController

	def create
		session_uuid = params[:session_uuid]
		machine_uuid = params[:machine_uuid]
		start_time = params[:start_time]

		if start_time.nil?
			response_message = {message: "start_time is a required parameter"}
			response_status = 400
		else
			machine = Machine.where(machine_uuid: machine_uuid).first
			if machine.nil?
				response_message = {message: "Machine with UUID #{machine_uuid} does not exist"}
				response_status = 404 
			else
				@machine_session = Session.where(session_uuid: session_uuid).first
				if @machine_session.nil?
					@machine_session = Session.new	do |s|
						s.session_uuid = session_uuid
						s.machine = machine
						s.start_time = DateTime.parse start_time
						s.coin_count = 0
					end
					response_message, response_status = update_session 201
				else
					response_message = {message: "Can't create session #{session_uuid} because it already exists"}
					response_status = 400 
				end
			end
		end
		render json: response_message, status: response_status

	end

	def update
		session_uuid = params[:session_uuid]
		machine_uuid = params[:machine_uuid]
		coin_count = params[:coin_count]
		end_time = params[:end_time]
		@machine_session = Session.find_existing_session_for_machine(session_uuid, machine_uuid)
		if @machine_session.nil?
			response_message = {message: "Session with uuid #{session_uuid} not found for Machine with uuid #{machine_uuid}"}
			response_status = 404 
		else
			if not end_time.nil? 
				if @machine_session.end_time.nil?
					end_time_obj = DateTime.parse end_time
					if end_time_obj > @machine_session.start_time
						@machine_session.end_time = end_time_obj
						response_message, response_status = update_session
					else
						response_message = {message: 'End date is before start date'}
						response_status = 400 
					end
				else
					response_message = {message: 'Session is already closed'}
					response_status = 400 
				end
			elsif coin_count.nil?
				response_message = {message: 'Request should include the coin count'}
				response_status = 400 
			else
				@machine_session.coin_count = coin_count
				response_message, response_status = update_session
			end
		end
		render json: response_message, status: response_status
	end

	private

	def update_session(success_code=200)
		if @machine_session.save
			response_message = {message: 'Session Updated Successfully'}
			response_status = success_code 
		else
			response_message = {message: 'Oops! seems like an internal error occured'}
			response_status = 500 
		end
		return response_message, response_status
	end

end
