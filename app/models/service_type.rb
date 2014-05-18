class ServiceType < ActiveRecord::Base
  belongs_to :user
  has_many :services

  def to_s
    self.name
  end
end
