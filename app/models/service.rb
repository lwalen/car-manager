class Service < ActiveRecord::Base
  belongs_to :car
  has_one :service_type
end
