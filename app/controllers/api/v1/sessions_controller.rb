class Api::V1::SessionsController < ApplicationController

	def create
		session_uuid = params[:session_uuid]
		machine_uuid = params[:machine_uuid]
		puts "Session uuid: #{session_uuid}, Machine UUID: #{machine_uuid}"
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
					s.coin_count = 1
				end
				if @machine_session.save
					response_message = {message: 'Session Created'}
					response_status = 201 
				else
					response_message = {message: 'Oops! seems like an internal error occured'}
					response_status = 500 
				end
			else
				response_message = {message: "Can't create session #{session_uuid} because it already exists"}
				response_status = 400 
			end
		end
		render json: response_message, status: response_status

	end

	def update
		session_uuid = params[:session_uuid]
		machine_uuid = params[:machine_uuid]
		coin_count = params[:coin_count]
		machine = Machine.where(machine_uuid: machine_uuid).first
		if machine.nil?
			response_message = {message: 'Machine does not exist'}
			response_status = 404 
		else
			@machine_session = Session.where(session_uuid: session_uuid).first
			if @machine_session.nil?
				response_message = {message: "Can't update session #{session_uuid} because it does not exist."}
				response_status = 400 
			else
				if coin_count.nil?
					response_message = {message: 'Request should include the coin count'}
					response_status = 400 
				else
					@machine_session.coin_count = coin_count
					if @machine_session.save
						response_message = {message: 'Session Updated'}
						response_status = 200 
					else
						response_message = {message: 'Oops! seems like an internal error occured'}
						response_status = 500 
					end
				end
			end
		end
		render json: response_message, status: response_status
	end

end
