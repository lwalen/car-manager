class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	helper_method :current_user, :user_signed_in?, :message

	def current_user
		User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
	end

	def signout_current_user
		cookie[:auth_token] = nil
	end

	def user_signed_in?
		cookies[:auth_token] ? true :	false
	end

	def message(type, content)
		flash[:notice_type] = type
		flash[:notice] = content
	end
end