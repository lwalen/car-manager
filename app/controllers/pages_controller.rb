class PagesController < ApplicationController

  def index
    if current_user
      if current_user.cars.empty?
        redirect_to cars_path
      else
        redirect_to car_path(current_user.primary_car)
      end
    end
  end
end
