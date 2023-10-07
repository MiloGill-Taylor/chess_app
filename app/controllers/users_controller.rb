class UsersController < ApplicationController
	def new
		@user = User.new
	end 

	def create
		@user = User.new(user_params(params))
		if @user.save
			flash[:success] = "Successfully created your profile"
			# Need to log in
			redirect_to @user
		else
			render 'new', status: :unprocessable_entity
		end 
	end 

	def show
	 @user = User.find(params[:id]) 
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
end
