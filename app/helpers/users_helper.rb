module UsersHelper
	def gravatar_for(user, options = {:size => 30 })
		gravatar_image_tag(user.email.downcase, :alt => user.name,
																																								:class => 'gravatar round',
																																								:gravatar => options)
	end
	
	def error(field)
    if @user.errors[field].any?
        raw @user.errors[field].first
    end
	end
end
