class ServiceRecord < Record

  has_and_belongs_to_many :service_types
  
  before_destroy :clean_types

  def to_s
    "#{date} #{mileage} #{cost} #{service_types_list} #{notes}"
  end

  def clean_types
    service_types.each do |service_type|
      other_records = service_type.service_records - [self]
      if other_records.empty?
        service_type.destroy
      end
    end
  end

  def service_types_list
    service_types.join(', ')
  end
end
