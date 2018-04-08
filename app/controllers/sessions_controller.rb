class SessionsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id   # stores in sessions hash, backed by browsers cookies
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      # flash.now will keep message to the current page (since render new isnt considered new request)
      # and flash exists on current request -- 
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

end

  
  