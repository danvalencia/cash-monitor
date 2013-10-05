class MaquinetsController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @maquinet = Maquinet.new
  end

  def show
    @maquinet = Maquinet.find params[:id]
  end

  def edit
    @maquinet = Maquinet.find params[:id]
  end

  def index
    @maquinets = Maquinet.find :all
    logger.debug "Maquinets: #{@maquinets}"
  end

  def create
    @maquinet = Maquinet.new(params[:maquinet])
    @maquinet.machine_uuid = SecureRandom.uuid
    if @maquinet.save
      redirect_to @maquinet
    else
      render :action => :new
    end  
  end

  def update
    @maquinet = Maquinet.find params[:id]
    if @maquinet
      if(@maquinet.update_attributes params[:maquinet])
        redirect_to @maquinet
      else
        render :action => :edit
      end
    else
      render action: :edit
    end
  end

  def destroy
  end
end
