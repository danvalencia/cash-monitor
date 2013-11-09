class Api::V1::SessionsController < ApplicationController

	def update
		render json: {works: 'Update!'}
	end
end
