class Record < ActiveRecord::Base

  belongs_to :car
  after_save :update_mpg

  def update_mpg
    self.car.update_mpg
  end

  def stat?
    self.stat
  end

  def to_s
    "#{self.date} #{self.mileage} #{self.gallons} #{self.cost}"
  end
end
