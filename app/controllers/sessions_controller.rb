class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user, notice: "Logged in"
    else
      flash.now.alert = "Invalid email or password"
      render 'new'
    end
  end
  def destroy
    sign_out
    redirect_to root_url, notice: "Come back soon!"
  end
end
