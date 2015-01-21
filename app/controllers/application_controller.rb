class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def message(type, content)
    flash[:notice_type] = type
    flash[:notice] = content
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
