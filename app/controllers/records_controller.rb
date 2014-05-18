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
      redirect_to car_path(@record.car, :anchor => 'tab_gas')
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
      redirect_to car_path(car, :anchor => 'tab_gas')
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

  def stat?
    @record.stat == 't'
  end

  def toggle_stats
    @record = Record.find(params[:id])
    if @record.stat?
      @record.update(stat: false)
    else
      @record.update(stat: true)
    end
    redirect_to car_path(@record.car, :anchor => 'tab_gas')
  end

  private
  def record_params
    params.require(:record).permit(:car_id, :date, :mileage, :gallons, :cost)
  end
end
