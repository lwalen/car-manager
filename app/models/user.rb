class User < ActiveRecord::Base

	validates :username, 
		presence: true, 
		uniqueness: true, 
		length: {within: 4..32}
	validates :password, 
		presence: true, 
		length: {within: 6..40},
		on: :create

	has_secure_password

	has_many :cars
	has_many :service_types

	before_create { generate_token :auth_token }

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def primary_car
		self.cars.where(main: true).first
	end

	def to_s
		"#{self.username}"
	end
end
