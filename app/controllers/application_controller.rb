class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  # def authenticate_admin!
  # 	unless user_signed_in? and current_user.admin?
  # 	  redirect_to new_user_session_path
  # 	end
  # end
end
