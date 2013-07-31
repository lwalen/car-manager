class Car < ActiveRecord::Base

	has_many :records

	def to_s
		"#{self.name}"
	end
end
