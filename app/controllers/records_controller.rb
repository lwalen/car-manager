class RecordsController < ApplicationController

  def new
  end

  def create
    @record = Record.new(record_params)
    @record.date = @record.date.strftime('%Y-%m-%d')

    if @record.mileage.nil? || @record.gallons.nil?
      # disable mileage stats for record
    end

    if @record.cost.nil?
      #disable price stats for record
    end

    if @record.date.nil?
      #disable time stats for record
    end

    if @record.save
      @records = @record.car.records
      message 'success', "Record successfully created."
      redirect_to @record.car
    else
      render action: "new"
    end
  end

  def destroy
    @record = Record.find(params[:id])
    car = @record.car
    if current_user.id == car.user_id
      @record.destroy
      message 'success', "Record deleted successfully."
      redirect_to car
    else
      message 'error', "You do not have permission to delete this record."
      redirect_to cars_url
    end
  end

  def upload
    @records = []
  end

  def add_multiple
      #message 'success', params[:new_records][:content]
      message 'success', "Added X records to CAR"
      redirect_to cars_url
  end

  def enable_stats
    @record = Record.find(params[:id])
    @record.stat = true
    @record.save
    redirect_to @record.car
  end

  def disable_stats
    @record = Record.find(params[:id])
    @record.stat = false
    @record.save
    redirect_to @record.car
  end

  private
  def record_params
    params.require(:record).permit(:car_id, :date, :mileage, :gallons, :cost)
  end
end
