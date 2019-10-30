class UsersController < ApplicationController
  before_action :require_user_logged_in, only:[:show]
  before_action :correct_user, only:[:show]
  before_action :set_user, only:[:show,:edit,:update,:anaylsis]

  def show
    # @tasks = current_user.tasks.where(sort_expired:(Date.today + 7.day)..Date.today)
    @tasks = current_user.tasks.where.not(sort_expired: Time.zone.today + 7.day..Float::INFINITY).order(sort_expired: :ASC)
  end

  def anaylsis
    # @tasks = current_user.tasks
    @labels = Label.all
  end

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] ='Signed up!!'
      log_in @user
      redirect_to @user
    else
      flash[:danger] ='Failed..'
      render 'new'
    end
  end

  def edit
  end

  def update
    @user.update params.require(:user).permit(:avatar)
    flash[:success] ='Create new avatar!'
    redirect_back(fallback_location: root_path)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to new_session_path
    end
  end
end
