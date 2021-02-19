class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[show]

  def new
    @user = User.new
  end

  def show
    @users_event = current_user.events
    @upcoming_events = current_user.upcoming_events
    @previous_events = current_user.previous_events
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to root_path, notice: 'Username successfully created'
    else
      redirect_to root_path, alert: `Username,  #{@user.errors[:name][0]}`
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
