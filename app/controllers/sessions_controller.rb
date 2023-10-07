class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      log_in @user 
      flash[:success] = "Successfully logged in"
      redirect_to forwarding_url || @user # this means if the first is nil do the second 
    else
      flash.now[:warning] = "invalid email/password combination"
      render 'new', status: :unprocessable_entity
    end 
  end

  def destroy
    log_out if logged_in?
    flash[:success] = 'Successfully logged out'
    redirect_to root_url, status: :see_other
  end
end
