class Service < ActiveRecord::Base
  belongs_to :car
  has_one :service_type


  def to_s
    "#{self.date} #{self.mileage} #{self.type} #{self.notes}"
  end
end
