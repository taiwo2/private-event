class UsersController < ApplicationController
  before_action :require_signed_in, only: [:show]  
  def new
    @user = User.new
  end

  def sign_out
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to '/', notice: 'Signed out successfully' }
      format.json { head :no_content }
    end
  end

  def show
    @user = User.find_by(id: session[:user_id])
  end

  def log_in
    @user = User.find_by(name: params[:name])
    if @user
      session[:user_id] = @user.id
      respond_to do |format|
        format.html { redirect_to '/', notice: 'Logged in successfully' }
        format.json { head :no_content }
      end
    else
      session[:user_id] = nil
      respond_to do |format|
        format.html { redirect_to '/', alert: 'Username not found' }
        format.json { head :no_content }
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      respond_to do |format|
        format.html { redirect_to '/', notice: 'Username successfully created' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to '/', alert: `Username,  #{@user.errors[:name][0]}` }
        format.json { head :no_content }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def require_signed_in
    if !@user_signed_in
      respond_to { |format| format.html { redirect_to '/sessions/new', alert: 'You have to be signed in!' } }
    end
  end
end