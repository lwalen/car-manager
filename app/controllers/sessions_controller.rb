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
			message 'success', "Welcome, #{user}!"
			if user.primary_car.nil?
				redirect_to cars_path
			else
				redirect_to user.primary_car
			end
		else
			message 'danger', "Invalid user/password combination."
			redirect_to root_path
		end
	end

	def destroy
		cookies.delete(:auth_token)
		message 'success', "You have been signed out."
		redirect_to root_path
	end
end
