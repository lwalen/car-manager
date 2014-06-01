class ServiceRecordsController < ApplicationController
  
  def new
  end

  def create
    p = service_params
    service_type = p[:service_type]
    p[:service_type] = ServiceType.find_by_name(p[:service_type]) ||
      ServiceType.create(name: p[:service_type], user: current_user)

    @service = ServiceRecord.new(p)
    @service.date = @service.date.strftime('%Y-%m-%d')

    if @service.save
      @services = @service.car.service_records
      message 'success', "Service successfully created."
      redirect_to car_path(@service.car, :anchor => 'tab_service')
    else
      render action: "new"
    end
  end

  def destroy
    @service = ServiceRecord.find(params[:id])
    car = @service.car
    if current_user.id == car.user_id
      @service.destroy
      message 'success', "Service deleted successfully."
      redirect_to car_path(car, :anchor => 'tab_service')
    else
      message 'error', "You do not have permission to delete this service."
      redirect_to cars_url
    end
  end

  private
  def service_params
    params.require(:service_record).permit(:car_id, :date, :mileage, :cost, :service_type, :notes)
  end
end
