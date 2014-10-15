class ServiceRecord < Record

  has_and_belongs_to_many :service_types
  
  after_destroy :clean_types

  def to_s
    "#{self.date} #{self.mileage} #{self.cost} #{self.service_type} #{self.notes}"
  end

  def clean_types
    if !self.service_type.nil? && self.service_type.service_records.empty?
      self.service_type.destroy
    end
  end
end
