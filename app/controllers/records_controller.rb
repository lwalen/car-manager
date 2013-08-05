class RecordsController < ApplicationController
	def new
	end

	def create
		@record = Record.new(record_params)
		
		if @record.mileage.nil? || @record.gallons.nil?
			# disable mileage stats for record
		end

		if @record.cost.nil?
			#disable price stats for record
		end

		if @record.date.nil?
			#disable time stats for record
		end

		respond_to do |format|
			if @record.save
				@records = @record.car.records
				message 'success', "Record successfully created."
				format.html { redirect_to @record.car }
				format.js   { render layout: false }
			else
				format.html { render action: "new" }
				format.json { render json: @car.errors, status: :unprocessable_entity }
				format.js   { render layout: false }
			end
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

	private
		def record_params
			params.require(:record).permit(:car_id, :date, :mileage, :gallons, :cost)
		end
end
