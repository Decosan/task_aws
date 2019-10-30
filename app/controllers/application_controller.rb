class ApplicationController < ActionController::Base
  http_basic_authenticate_with :name => ENV['BASIC_AUTH_USERNAME'], :password => ENV['BASIC_AUTH_PASSWORD'] if Rails.env == "production"

  protect_from_forgery with: :exception

  include SessionsHelper

  def require_user_logged_in
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def counts(user)
    @task_count = user.tasks.count
  end

  def count(users)
    @user_count = users.count
  end

end
