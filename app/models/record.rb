class Record < ActiveRecord::Base

	belongs_to :car

	def to_s
		"#{self.date} #{self.mileage} #{self.gallons} #{self.cost}"
	end
end
