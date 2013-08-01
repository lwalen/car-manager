class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			if params[:remember_me]
				cookies.permanent[:auth_token] = user.auth_token
			else
				cookies[:auth_token] = user.auth_token
			end
			message 'success', "You have been signed in as #{user}"
			redirect_to root_path
		else
			message 'error', "Invalid user/password combination"
			redirect_to signin_url
		end
	end

	def destroy
		cookies.delete(:auth_token)
		message 'success', "You have been signed out"
		redirect_to root_path
	end
end
