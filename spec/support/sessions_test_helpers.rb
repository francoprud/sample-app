module SessionsTestHelpers
  # Logs in a test user
  def log_in_as(user)
    session[:user_id] = user.id
  end
end
