class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @car = Car.new
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      message 'danger', "You do not have permission to edit this user."
      redirect_to @user
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      cookies[:auth_token] = @user.auth_token
      message 'success', "User #{@user.username} was successfully created."
      redirect_to cars_path
    else
      message 'danger', "Your account could not be created. Sorry!"
      redirect_to register_path
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      message 'success', "User #{@user.username} was successfully updated."
      redirect_to user_path(@user)
    else
      render action: "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless current_user.id == @user.id
      message 'danger', "You do not have permission to delete this user."
      redirect_to users_path
    else
      @user.destroy
      logout_current_user
      message 'success', "Your account was deleted."
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
