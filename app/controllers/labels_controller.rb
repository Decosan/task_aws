class LabelsController < ApplicationController
  before_action :set_label, only:[:edit,:update,:destroy]

  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      flash[:success] ='New Label created'
      redirect_to anaylsis_user_path(current_user.id)
    else
      flash[:danger] ="Failed.."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @label.update(label_params)
      flash[:success] ='New Label created'
      redirect_to anaylsis_user_path(current_user.id)
    else
      flash[:danger] ="Failed.."
      render 'edit'
    end
  end

  def destroy
    @label.destroy
    flash[:danger] ='Deleted..'
    redirect_back(fallback_location: root_path)
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:title)
  end

end
