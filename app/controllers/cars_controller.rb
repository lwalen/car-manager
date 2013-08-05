class CarsController < ApplicationController
	def index
		@cars = current_user.cars
	end

	def show
		@car = Car.find(params[:id])
		@records = @car.records.all

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

	def car_params
		params.require(:car).permit(:name)
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
		if current_user.id == @car.user_id
			@car.destroy
			message 'success', "Car deleted successfully."
			redirect_to cars_url
		else
			message 'error', "You do not have permission to delete this car."
			redirect_to cars_url
		end
	end

	def make_primary
		@car = Car.find(params[:id])
		@current_primary = Car.where("main = 't'").first
		@current_primary.main = false
		@car.main = true
		if @car.save && @current_primary.save
			respond_to do |format|
				format.html { redirect_to cars_url }
			end
		else 
			message 'error', "Failed to set car as primary"
		end
	end
end
