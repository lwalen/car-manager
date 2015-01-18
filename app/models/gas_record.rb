class GasRecord < Record

  after_save :update_mpg
  after_destroy :update_mpg

  alias_attribute :distance, :mileage

  def update_mpg
    car.update_mpg
  end

  def stat?
    stat
  end

  def to_s
    "#{date} #{distance} #{volume} #{cost}"
  end
end
