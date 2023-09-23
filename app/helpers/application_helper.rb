module ApplicationHelper
	def full_title view_title
		@base = 'Chess'
		if view_title == 'Home'
			@base
		else
			"#{view_title} | #{@base}"
		end 
	end 
end
