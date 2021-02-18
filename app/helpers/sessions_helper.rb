module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: cookies[:auth_token]) if cookies[:auth_token]
  end
end
