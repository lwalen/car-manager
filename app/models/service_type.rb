class ServiceType < ActiveRecord::Base

  validates :name,
    presence: true,
    uniqueness: { scope: :user_id }

  belongs_to :user
  has_and_belongs_to_many :service_records

  def to_s
    self.name
  end
end
