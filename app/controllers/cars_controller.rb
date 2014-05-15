class CarsController < ApplicationController
  def index
    @cars = current_user.cars.order(:created_at)
  end

  def show
    @car = Car.find(params[:id])
    @records = @car.records.order('mileage DESC').limit(10)

    filename = "#{@car.name.tr(' ', '_')}.csv"

    respond_to do |format|
      format.html
      format.csv { send_data @car.to_csv, filename: filename }
    end
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user_id = current_user.id
    if Car.find_by_user_id(current_user.id).nil?
      @car.main = true
    end

    if @car.save
      message 'success', "Car #{@car.name} was successfully created."
      redirect_to cars_url
    else
      render action: "new"
    end
  end

  def edit
    @car = Car.find(params[:id])
    unless current_user.id == @car.user_id
      message 'error', "You do not have permission to view this page."
      redirect_to current_user
    end
  end

  def update
    @car = Car.find(params[:id])

    if @car.update_attributes(params[:car])
      message 'success', "Car '#{@car.name}' was successfully updated."
      redirect_to user_path(@car.user_id)
    else
      render action: "edit"
    end
  end

  def destroy
    @car = Car.find(params[:id])
    
    if current_user.id == @car.user_id
      name = @car.name
      @car.destroy
      message 'success', "#{name} deleted successfully. Undo?", false
      redirect_to cars_url
    else
      message 'danger', "You do not have permission to delete this car."
      redirect_to cars_url
    end
  end

  def make_primary
    @car = Car.find(params[:id])
    @current_primary = current_user.primary_car
    @current_primary.update(main: false) if !@current_primary.nil?
    result = @car.update(main: true)
    if @car = current_user.primary_car
      message 'success', "Changed primary car to #{@car}."
      redirect_to cars_url
    else 
      message 'danger', "Failed to set car as primary."
      redirect_to cars_url
    end
  end

  def service

  end

  private
  def car_params
    params.require(:car).permit(:name)
  end
end
