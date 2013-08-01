class Car < ActiveRecord::Base

	has_many :records

	def primary?
		self.main
	end

	def to_s
		"#{self.name}"
	end
end
