class TasksController < ApplicationController
  before_action :set_params, only:[:show,:edit,:update,:destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only:[:show,:edit,:update,:destroy]
  before_action :delete_picture, only:[:update]
  

  def index
    if params[:task] && params[:task][:search]
      if params[:task][:title] == "" && params[:task][:status] == "" && params[:task][:label_ids] == ""
        redirect_to tasks_path
        # redirect_back(fallback_location: root_path)
      elsif params[:task][:title].present? && params[:task][:status].present?
        @tasks = current_user.tasks.title_search(params[:task][:title]).status_search(params[:task][:status]).page(params[:page])
      elsif params[:task][:title].present?
        @tasks = current_user.tasks.title_search(params[:task][:title]).page(params[:page])
      elsif params[:task][:status].present?
        @tasks = current_user.tasks.status_search(params[:task][:status]).page(params[:page])
      elsif params[:task][:label_ids].present?
        @tasks = current_user.tasks.joins(:task_labels).where('task_labels.label_id = ?', params[:task][:label_ids]).page(params[:page])
      end
    elsif params[:sort_expired]
      @tasks = current_user.tasks.nil_limit.limit_sort.page(params[:page])
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order('priority DESC').page(params[:page])
    else
      @tasks = current_user.tasks.all.order('created_at DESC').page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    # if file = params[:task][images: []]
    #   @task.images.attach(file)
    # end
    if @task.save
      # ContactMailer.contact_mail(current_user).deliver
      flash[:success] = t("view.success")
      redirect_to tasks_path
    else
      flash[:danger] = t("view.failed")
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = t("view.success")
      redirect_to tasks_path
    else
      flash[:danger] = t("view.failed")
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:danger] = t("view.deleted")
    redirect_to tasks_path
  end

  private

  def set_params
    @task = Task.find(params[:id])
  end
  
  def delete_picture
    if images = params[:task][:destroy_images]
      images.each do |img| 
        @task.images.find(img).destroy
      end
      redirect_back(fallback_location: root_path)
    else

    end
  end

  def task_params
    params.require(:task).permit(:title,:content,:sort_expired,:status,:priority,label_ids: [],images: [])
  end

  def correct_user
    unless current_user.id == @task.user.id
      redirect_to new_session_path
    end
  end
end
