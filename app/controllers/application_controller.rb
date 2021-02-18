class ApplicationController < ActionController::Base
  before_action :check_user_signed_in
  include SessionsHelper

  private

  def check_user_signed_in
    if session[:user_id].nil?
      @user_signed_in = false
    else
      @user = User.find_by(id: session[:user_id])
      @user_signed_in = true
    end
  end
end
