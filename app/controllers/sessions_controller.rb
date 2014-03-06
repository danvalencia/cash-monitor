class SessionsController < ApplicationController
  before_filter :authenticate_user!

  def index
  	if params[:machine_uuid]
  		logger.info "Here"
	  	@sessions = Session.for_machine(params[:machine_uuid], params[:page])
	  	render partial: 'index'
  	else
	  	render json: {machine: params}
  	end
  end
end
