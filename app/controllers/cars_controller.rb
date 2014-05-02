class CarsController < ApplicationController
  def index
    @cars = current_user.cars.order(:created_at)
  end

  def show
    @car = Car.find(params[:id])
    @records = @car.records.order(:mileage)

    respond_to do |format|
      format.html
      format.json { render json: @car }
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

    respond_to do |format|
      if @car.save
        message 'success', "Car #{@car.name} was successfully created."
        format.html { redirect_to cars_url }
        format.json { render json: @car, status: :created, location: @car }
      else
        format.html { render action: "new" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
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

    respond_to do |format|
      if @car.update_attributes(params[:car])
        message 'success', "Car '#{@car.name}' was successfully updated."
        format.html { redirect_to user_path(@car.user_id) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @car = Car.find(params[:id])

=begin
    if @car.primary?
      @new_primary = Car.where("main = 'f'").first
      @new_primary.main = true
      @new_primary.save
    end
=end

    if current_user.id == @car.user_id
      name = @car.name
      @car.destroy
      message 'success', "#{name} deleted successfully."
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

  private
  def car_params
    params.require(:car).permit(:name)
  end
end
