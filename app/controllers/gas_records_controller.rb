class GasRecordsController < ApplicationController

  def index
    @car = current_user.cars.find(params[:car_id]) || not_found

    respond_to do |format|
      format.csv do
        filename = "#{@car.name.tr(' ', '_')}_#{Date.today.strftime("%Y%m%d")}_gas.csv"
        send_data @car.to_csv(:gas), filename: filename
      end
    end
  end

  def new
  end

  def create
    @record = GasRecord.new(record_params)
    @record.date = @record.date.strftime('%Y-%m-%d')

    if @record.mileage.nil? || @record.volume.nil?
      # disable mileage stats for record
    end

    if @record.cost.nil?
      #disable price stats for record
    end

    if @record.date.nil?
      #disable time stats for record
    end

    if @record.save
      @records = @record.car.gas_records
      message 'success', "Record successfully created."
      redirect_to car_path(@record.car, :anchor => 'tab_gas')
    else
      render action: "new"
    end
  end

  def destroy
    @record = GasRecord.find(params[:id])
    car = @record.car
    if current_user.id == car.user_id
      @record.destroy
      message 'success', "Record deleted successfully."
      redirect_to car_path(car, :anchor => 'tab_gas')
    else
      message 'error', "You do not have permission to delete this record."
      redirect_to cars_url
    end
  end

  def toggle_stats
    @record = GasRecord.find(params[:id])
    if @record.stat?
      @record.update(stat: false)
    else
      @record.update(stat: true)
    end
    redirect_to car_path(@record.car, :anchor => 'tab_gas')
  end

  private
  def record_params
    params.require(:gas_record).permit(:car_id, :date, :mileage, :volume, :cost)
  end
end
