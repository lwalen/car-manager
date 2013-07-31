module ApplicationHelper
	def cancel_link
		return link_to 'Cancel', request.env["HTTP_REFERER"], 
			:class => 'btn'
	end
end
