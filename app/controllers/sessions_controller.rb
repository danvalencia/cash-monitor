class SessionsController < ApplicationController
  before_filter :authenticate_user!

  def index
  	if params[:machine_uuid]
	  	@sessions = Session.for_machine(params[:machine_uuid], params[:page])
	  	render partial: 'index'
  	end
  end
end
