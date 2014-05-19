class UsersController < ApplicationController

  def show
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
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
    @user = current_user

    if @user.update(user_settings)
      message 'success', "Settings saved."
    else
      message 'danger', "Settings could not be saved. Sorry!"
    end
    render action: :edit
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

  def user_settings
    params.require(:user).permit(:number_of_records, :distance_unit, :volume_unit)
  end
end
