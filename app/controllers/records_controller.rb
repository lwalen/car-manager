class RecordsController < ApplicationController
  def new
  end

  def create
		@record = Record.new(record_params)
		@records = Record.all

		respond_to do |format|
			if @record.save
				message 'success', "Record successfully created."
				format.html { redirect_to @record.car }
				format.js   { render layout: false }
				#format.json { render json: @car, status: :created, location: @car }
			else
				format.html { render action: "new" }
				format.json { render json: @car.errors, status: :unprocessable_entity }
			end
		end
  end

	def record_params
		params.require(:record).permit(:car_id, :date, :mileage, :gallons, :cost)
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
end
