class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def authenticate_user
    redirect_to new_session_path, alert: 'Please login or signup to continue' unless user_signed_in?
  end
end
