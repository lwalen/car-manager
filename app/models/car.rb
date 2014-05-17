class Car < ActiveRecord::Base

  has_many :records
  has_many :services

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
    self.main
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
