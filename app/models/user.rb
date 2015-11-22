class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :number_of_gas_records,
		presence: true,
		numericality: { greater_than_or_equal_to: 0 }
	validates :number_of_service_records,
		presence: true,
		numericality: { greater_than_or_equal_to: 0 }

	has_many :cars
	has_many :service_types
	belongs_to :primary_car, class_name: 'Car'

	def to_s
		"#{self.username}"
	end

  def distance_unit
    read_attribute(:distance_unit) || 'Miles'
  end

  def volume_unit
    read_attribute(:volume_unit) || 'Gallons'
  end
end
