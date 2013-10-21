class UsersController < ApplicationController
  #before_filter :authenticate_admin!
  
  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
  end

  def index
    @users = User.find :all
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user
    else
      render :action => :new
    end  
  end

  def update
    @user = User.find params[:id]
    if @user
      logger.debug "User Params: #{params[:user]}"
      params[:user].delete(:current_password)
      logger.debug "About to update without password"
      if(@user.update_without_password params[:user])
        redirect_to @user
      else
        logger.debug "User is #{@user}, Errors is: #{@user.errors}"
        render :action => :edit
      end
    else
      render action: :edit
    end
  end

  def destroy
  end

end
