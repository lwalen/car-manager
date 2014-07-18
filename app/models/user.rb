class User < ActiveRecord::Base

	validates :username, 
		presence: true, 
		uniqueness: true, 
		length: {within: 4..32}
	validates :password, 
		presence: true, 
		length: {within: 6..128},
		on: :create
	validates :number_of_gas_records,
		presence: true,
		numericality: { greater_than_or_equal_to: 0 }
	validates :number_of_service_records,
		presence: true,
		numericality: { greater_than_or_equal_to: 0 }

	has_secure_password

	has_many :cars
	has_many :service_types
	belongs_to :primary_car, class_name: 'Car'

	before_create { generate_token :auth_token }

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

	def to_s
		"#{self.username}"
	end
end
