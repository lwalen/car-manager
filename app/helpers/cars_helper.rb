module CarsHelper
  def mpg_label(short = false)
    if short
      "#{current_user.distance_unit[0].downcase}p#{current_user.volume_unit[0].downcase}"
    else
      "#{current_user.distance_unit.downcase} per #{current_user.volume_unit.downcase.singularize}"
    end
  end
end
