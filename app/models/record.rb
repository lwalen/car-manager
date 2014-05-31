class Record < ActiveRecord::Base

  validates :mileage, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :car
end
