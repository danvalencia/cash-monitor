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
    if current_user.admin?
      @maquinets = Maquinet.find :all
    else
      @maquinets = Maquinet.with_user(current_user)
    end

    logger.debug "Maquinets: #{@maquinets}"
  end

  def create
    if current_user.admin?
      user_id = params[:maquinet][:user_id]
      params[:maquinet].delete(:user_id) # To avoid mass-assignment error
      @maquinet = Maquinet.new(params[:maquinet])
      @maquinet.user_id = user_id
      if @maquinet.save
        redirect_to @maquinet
      else
        render :action => :new
      end  
    else
      render status: 401 
    end
  end

  def update
    @maquinet = Maquinet.find params[:id]
    if @maquinet
      @maquinet.user_id = params[:maquinet][:user_id]
      params[:maquinet].delete(:user_id) # To avoid mass-assignment error
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
