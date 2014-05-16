module ApplicationHelper
	def cancel_link
		return link_to 'Cancel', request.env["HTTP_REFERER"]
	end

  def add_s value
    if value != 1
      return 's'
    end
  end
end
