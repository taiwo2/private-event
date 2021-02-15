class UsersController < ApplicationController
  before_action :require_signed_in, only: [:show]
  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: session[:user_id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Username successfully created'
    else
      redirect_to root_path, alert: `Username,  #{@user.errors[:name][0]}`
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def require_signed_in
    return if @user_signed_in

    redirect_to new_session_path, alert: 'You have to be signed in'
  end
end
