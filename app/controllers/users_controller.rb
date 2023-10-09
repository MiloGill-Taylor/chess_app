class UsersController < ApplicationController
	before_action :logged_in_user, only: :show
	before_action :correct_user, only: :show
	def new
		@user = User.new
	end 

	def create
		@user = User.new(user_params(params))
		if @user.save
			flash[:success] = "Successfully created your profile"
			reset_session
			log_in @user 
			redirect_to @user
		else
			render 'new', status: :unprocessable_entity
		end 
	end 

	def show
	 @user = User.find(params[:id]) 
	 @games = @user.games
	end 

	def edit 
	end

	def update
	end 

	def destroy
	end 

	def index
	end 

	private 
		def user_params params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
		end 

		def logged_in_user 
			unless logged_in?
				store_location
				flash[:warning] = "Please log in"
				redirect_to(login_path, status: :see_other) 
			end 
		end 

		def correct_user
			user = User.find(params[:id])
			redirect_to(root_url, status: :see_other) unless current_user?(user)
		end 
end
