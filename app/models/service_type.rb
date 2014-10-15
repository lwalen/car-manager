class ServiceType < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :service_records

  def to_s
    self.name
  end
end
