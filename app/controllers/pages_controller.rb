class PagesController < ApplicationController
  def index
    if user_signed_in?
      redirect_to car_path(current_user.primary_car)
    end
  end
end
