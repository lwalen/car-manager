class Record < ActiveRecord::Base

  validates :mileage, numericality: { greater_than_or_equal_to: 0 }


  belongs_to :car
  after_save :update_mpg
  after_destroy :update_mpg

  def update_mpg
    self.car.update_mpg
  end

  def stat?
    self.stat
  end

  def to_s
    "#{self.date} #{self.mileage} #{self.volume} #{self.cost}"
  end
end
