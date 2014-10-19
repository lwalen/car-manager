class Car < ActiveRecord::Base

  validates :name,
    presence: true, 
    uniqueness: { scope: :user_id } 

  has_many :gas_records
  has_many :service_records
  belongs_to :user

  after_save :update_slug

  def update_mpg

  end

  def update_slug
    new_slug = self.name.parameterize
    self.update(slug: new_slug)
  end

  def primary?
    self.user.primary_car && self.id == self.user.primary_car.id
  end

  def to_s
    "#{self.name}"
  end

  def to_param
    slug
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['Date', 'Distance', 'Volume', 'Cost']
      gas_records.order(:mileage).each do |r|
        csv << [r.date, r.mileage, r.volume, r.cost]
      end
    end
  end
end
