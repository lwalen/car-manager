class CarsController < ApplicationController
  def index
    @cars = current_user.cars.order(:created_at)
  end

  def show
    @car = current_user.cars.find_by_slug(params[:id]) || not_found

    respond_to do |format|
      format.html do
        if params[:all]
          @remaining = 0
          @gas_records = @car.gas_records.order('mileage DESC')
        else
          limit = current_user.number_of_gas_records
          @remaining = @car.gas_records.all.count - limit
          @gas_records = @car.gas_records.order('mileage DESC').limit(limit)
        end

        @service_records = @car.service_records.order('mileage DESC')
        @service_types = current_user.service_types
      end

      format.csv do
        filename = "#{@car.name.tr(' ', '_')}_#{Date.today.strftime("%Y%m%d")}.csv"
        send_data @car.to_csv, filename: filename
      end
    end
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user_id = current_user.id

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
    @car = current_user.cars.find_by_slug(params[:id])
    unless current_user.id == @car.user_id
      message 'error', "You do not have permission to view this page."
      redirect_to current_user
    end
  end

  def update
    @car = current_user.cars.find_by_slug(params[:id])

    if @car.update_attributes(car_params)
      message 'success', "Car '#{@car.name}' was successfully updated."
      render json: "Car '#{@car.name}' was successfully updated."
    else
      render json: "Car could not be saved."
    end
  end

  def destroy
    @car = current_user.cars.find_by_slug(params[:id])
    
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

  def import
    @car = current_user.cars.find_by_slug(params[:id])
  end

  def upload
    @car = current_user.cars.find_by_slug(params[:id])

    require 'csv'
    CSV.foreach(params[:car][:records_csv].path,
                headers: true, 
                header_converters: lambda { |h| h.try(:downcase) }) do |row|
      unless row.empty?
        rec = GasRecord.create(row.to_hash.merge({car_id: @car.id}))
        puts rec.inspect
      end
    end

    if true
      message 'success', "gas_records for #{@car.name} were successfully imported."
      redirect_to car_path(@car)
    else
      message 'danger', "gas_records for #{@car.name} could not be imported."
      render action: "import"
    end
  end

  def more_records
    @records = Car.find_by_slug(params[:id]).gas_records.order('mileage DESC').all
    render @records
  end

  private
  def car_params
    params.require(:car).permit(:name)
  end
end
