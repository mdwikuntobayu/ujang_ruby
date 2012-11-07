module ApplicationHelper
	#return a title on a per-page
	def title
		base_title = "Ujang Rails"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
end
