class Api::V1::MachinesController < ApplicationController

	def update
		machine_uuid = params[:machine_uuid]
		coin_value = params[:coin_value]
		coin_time = params[:coin_time]

		@machine = Machine.where(machine_uuid: machine_uuid).first

		if @machine.nil?
			response_message = {message: 'Machine does not exist'}
			response_status = 404 
		elsif coin_time.nil? or coin_value.nil? 
			response_message = {message: 'coin_time and coin_value are required parameters'}
			response_status = 400 
		else
			@machine.coin_value = coin_value
			@machine.coin_time = coin_time

			if @machine.save
				response_message = {message: 'Machine Updated Successfully'}
				response_status = 200 
			else
				response_message = {message: 'Oops! seems like an internal error occured'}
				response_status = 500 
			end
		end

		render json: response_message, status: response_status
	end

end
