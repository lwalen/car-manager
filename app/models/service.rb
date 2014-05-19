class Service < ActiveRecord::Base

  validates :mileage, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :car
  belongs_to :service_type

  after_destroy :clean_types

  def to_s
    "#{self.date} #{self.mileage} #{self.cost} #{self.service_type} #{self.notes}"
  end

  def clean_types
    if !self.service_type.nil? && self.service_type.services.empty?
      self.service_type.destroy
    end
  end
end
