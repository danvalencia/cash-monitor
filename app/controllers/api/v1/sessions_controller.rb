class Api::V1::SessionsController < ApplicationController

	def update
		session_uuid = params[:session_uuid]
		machine_uuid = params[:machine_uuid]
		coin_count = params[:coin_count]
		puts "Session: #{session_uuid}, Machine: #{machine_uuid}, Coin Count: #{coin_count}"
		machine = Machine.where(machine_uuid: machine_uuid).first
		if machine.nil?
			respond_to do |format|
				format.json {
					render json: {message: 'Machine does not exist'}, status: 404 
				}	 
			end
		else
			@machine_session = Session.where(session_uuid: session_uuid).first
			if @machine_session.nil?
				coin_count = 1 if coin_count.nil?
				@machine_session = Session.new	do |s|
					s.session_uuid = session_uuid
					s.machine = machine
					s.coin_count = coin_count
				end
				respond_to do |format|
					if @machine_session.save
						format.json {
							render json: {message: 'Session Created'}, status: 201
						} 
					end
				end
			else
				if coin_count.nil?
					render json: {message: 'Request should include the coin count'}, status: 400
				else
					@machine_session.coin_count = coin_count
					respond_to do |format|
						if @machine_session.save
							puts "Machine Session Coin Count: #{@machine_session.coin_count}"
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
end
