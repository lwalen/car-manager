class Car < ActiveRecord::Base

  validates :name,
    presence: true, 
    uniqueness: { scope: :user_id } 

  has_many :gas_records
  has_many :service_records
  belongs_to :user

  after_save :update_slug

  def update_mpg
    mpg = []
    self.records.each_with_index do |rec, index|
      if index != 0 && rec.stat? && self.records[index-1].stat?
        miles = rec.mileage - self.records[index-1].mileage
        mpg.push(miles / rec.volume)
      end
    end

    self.mpg = mpg.inject{ |sum, el| sum + el }.to_f / mpg.size
    self.save
  end

  def update_slug
    new_slug = self.name.parameterize
    unless self.slug == new_slug
      self.update(slug: new_slug)
    end
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
      csv << ['Date', 'Mileage', self.user.volume_unit, 'Cost']
      records.each do |r|
        csv << [r.date, r.mileage, r.volume, r.cost]
      end
    end
  end
end
