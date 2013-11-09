class Api::V1::SessionsController < ApplicationController
	def create
		render json: {works: 'yay!'}
	end
end
