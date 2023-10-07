module SessionsHelper
	def log_in user 
		session[:session_token] = user.set_session_token 
		session[:user_id] = user.id 
	end 

	def current_user
		if session[:user_id]
			user = User.find_by(id: session[:user_id]) #Used to not raise an exception if the id is not in db
			if user && session[:session_token] == user.session_token 
				@current_user ||= user 
			end  
		end 
	end 

	def logged_in?
		!current_user.nil?
	end 

	def log_out  
		current_user.update_attribute(:session_token, nil)
		reset_session
		@current_user = nil
	end 

	def current_user? user 
		current_user == user 
	end 

	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end 
end
