class Car < ActiveRecord::Base

  validates :name,
    presence: true, 
    uniqueness: { scope: :user_id } 

  has_many :records
  has_many :services
  belongs_to :user

  def update_mpg
    mpg = []
    self.records.each_with_index do |rec, index|
      if index != 0 && rec.stat? && self.records[index-1].stat?
        miles = rec.mileage - self.records[index-1].mileage
        mpg.push(miles / rec.gallons)
      end
    end

    self.mpg = mpg.inject{ |sum, el| sum + el }.to_f / mpg.size
    self.save
  end

  def primary?
    return self.id == self.user.primary_car.id
  end

  def to_s
    "#{self.name}"
  end

  def to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << ['Date', 'Mileage', 'Gallons', 'Cost']
      records.each do |r|
        csv << [r.date, r.mileage, r.gallons, r.cost]
      end
    end
  end
end
