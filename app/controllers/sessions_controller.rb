class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      flash[:success] ="Logged In!!"
      log_in user
      redirect_to user_path(current_user)
    else
      flash[:danger] ="Failed.."
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:danger] ="Logged out!"
    redirect_to new_session_path
  end
end
