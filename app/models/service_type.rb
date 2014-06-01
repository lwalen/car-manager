class ServiceType < ActiveRecord::Base
  belongs_to :user
  has_many :service_records

  def to_s
    self.name
  end
end
