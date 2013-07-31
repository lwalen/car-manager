class UsersController < ApplicationController

	def index
		@users = User.all
	end

	# GET /users/1
	# GET /users/1.json
	def show
		@user = User.find(params[:id])
		@task = Task.new

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @user }
		end
	end

	# GET /users/new
	# GET /users/new.json
	def new
		@user = User.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @user }
		end
	end
	# GET /users/1/edit
	def edit
		@user = User.find(params[:id])
		unless current_user.id == @user.id
			message 'error', "You do not have permission to edit this user."
			redirect_to @user
		end
	end

	# POST /users
	# POST /users.json
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

	# PUT /users/1
	# PUT /users/1.json
	def update
		@user = User.find(params[:id])

		# if params[:user][:avatar] = ""
		# 	params[:user][:avatar] = @user.avatar
		# end

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

	# DELETE /users/1
	# DELETE /users/1.json
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
