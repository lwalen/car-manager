class ServicesController < ApplicationController
  
  def new
  end

  def create
    @service = Service.new(service_params)
    @service.date = @service.date.strftime('%Y-%m-%d')

    if @service.save
      @services = @service.car.services
      message 'success', "Service successfully created."
      redirect_to @service.car
    else
      render action: "new"
    end
  end

  def destroy
    @service = Service.find(params[:id])
    car = @service.car
    if current_user.id == car.user_id
      @service.destroy
      message 'success', "Service deleted successfully."
      redirect_to car
    else
      message 'error', "You do not have permission to delete this service."
      redirect_to cars_url
    end
  end

  private
  def service_params
    params.require(:service).permit(:car_id, :date, :mileage, :type, :notes)
  end
end
