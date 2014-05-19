class CarsController < ApplicationController
  def index
    @cars = current_user.cars.order(:created_at)
  end

  def show
    @car = Car.find(params[:id])
    @long_mpg = "#{current_user.distance_unit.downcase} 
                 per #{current_user.volume_unit.downcase}"
    @mpg = "#{current_user.distance_unit[0].downcase}p#{current_user.volume_unit[0].downcase}"

    if params[:all]
      @remaining = 0
      @records = @car.records.order('mileage DESC')
    else
      limit = current_user.number_of_records
      @remaining = @car.records.all.count - limit
      @records = @car.records.order('mileage DESC').limit(limit)
    end
    @services = @car.services.order('mileage DESC')

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

    if res = @car.save
      message 'success', "Car #{@car.name} was successfully created."
      redirect_to cars_url
    else
      messages = @car.errors.to_a.join(' and ').downcase
      message 'danger', "Couldn't create car because #{messages}."
      redirect_to cars_url
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
      message 'success', "#{name} deleted successfully."
      redirect_to cars_url
    else
      message 'danger', "You do not have permission to delete this car."
      redirect_to cars_url
    end
  end

  private
  def car_params
    params.require(:car).permit(:name)
  end
end
