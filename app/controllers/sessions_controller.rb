class SessionsController < ApplicationController
  def create
    @user = User.find_by(name: params[:name])

    if @user
      login(@user)
      redirect_to root_path, notice: 'Logged in successfully'
    else
      redirect_to root_path, alert: 'Username not found'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Signed out successfully'
  end
end
