module SessionsHelper
	#used for initialize first login
	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		current_user = user
	end
	#set method cookies user
	def current_user=(user)
		@current_user  = user
	end
	#get method cookies user
	def current_user
		@current_user ||= user_from_remember_token
  end
	#used for check user is login, if login will return true
	def signed_in?
		!current_user.nil?
	end
	#used for destroy cookies
	def sign_out
		cookies.delete(:remember_token)
		self.current_user = nil
	end
	
	def current_user?(user)
		user == current_user
	end
		
	def deny_access
		store_location
		redirect_to signin_path, :notice => "please Sign In to access page" unless signed_in?
	end
	
	def store_location
		session[:return_to] = request.fullpath
	end
	
	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		clear_return_to
	end
	
	def clear_return_to
		session[:return_to] = nil
	end
		
		private
				
				def user_from_remember_token
					User.authenticate_with_salt(*remember_token)
				end
				
				def remember_token
					cookies.signed[:remember_token] || [nil, nil]
				end
end
