class Record < ActiveRecord::Base

	def to_s
		"#{self.date} #{self.mileage} #{self.gallons} #{self.cost}"
	end
end
