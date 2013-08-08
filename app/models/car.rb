class Car < ActiveRecord::Base

	has_many :records

	def update_mpg
		mpg = []
		self.records.each_with_index do |rec, index|
			if index != 0 && rec.stat? && self.records[index-1].stat?
				miles = rec.mileage - self.records[index-1].mileage
				mpg.push(miles / rec.gallons)
			end
		end

		self.mpg = mpg.inject{ |sum, el| sum + el }.to_f / mpg.size
		self.save
	end

	def primary?
		self.main
	end

	def to_s
		"#{self.name}"
	end
end
