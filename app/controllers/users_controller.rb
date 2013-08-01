class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@car = Car.new

		respond_to do |format|
			format.html
			format.json { render json: @user }
		end
	end

	def new
		@user = User.new

		respond_to do |format|
			format.html
			format.json { render json: @user }
		end
	end

	def edit
		@user = User.find(params[:id])
		unless current_user.id == @user.id
			message 'error', "You do not have permission to edit this user."
			redirect_to @user
		end
	end

	def create
		@user = User.new(user_params)

		respond_to do |format|
			if @user.save
				cookies[:auth_token] = @user.auth_token
				message 'success', "User #{@user.username} was successfully created."
				format.html { redirect_to root_path }
				format.json { render json: @user, status: :created, location: @user }
			else
				format.html { render action: "new" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation)
	end

	def update
		@user = User.find(params[:id])

		respond_to do |format|
			if @user.update_attributes(params[:user])
				message 'success', "User #{@user.username} was successfully updated."
					format.html { redirect_to user_path(@user) }
					format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@user = User.find(params[:id])
		unless current_user.id == @user.id
			message 'error', "You do not have permission to delete this user."
			redirect_to users_path
		else
			@user.destroy
			logout_current_user
			message 'success', "Your account was deleted."
			redirect_to root_path
		end
	end
end
