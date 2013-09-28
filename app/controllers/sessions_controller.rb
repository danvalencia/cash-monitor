class SessionsController < ApplicationController
  def update
  	render json: { message: 'Session updated'}
  end
end
