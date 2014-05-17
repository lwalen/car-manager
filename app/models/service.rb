class Service < ActiveRecord::Base
  belongs_to :car
  belongs_to :service_type

  def to_s
    "#{self.date} #{self.mileage} #{self.service_type} #{self.notes}"
  end
end
