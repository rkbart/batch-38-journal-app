class TasksController < ApplicationController
  before_action :set_category, except: [ :index ]
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  before_action :referer, only: [ :new, :edit, :show ]
  def index
    @tasks = current_user.tasks.includes(:category)
    @tasks_today = @tasks.where(due_date: Date.today)
    @upcoming_tasks = @tasks.where("due_date > ?", Date.today)
    @overdue_tasks = @tasks.where("due_date < ?", Date.today)
  end
  def show; end

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.new(task_params)

    if @task.save
      session.delete(:return_to) # Clear stored referer
      redirect_to category_task_path(@category, @task), notice: "Task created successfully"
    else
      flash[:alert] = "Unable to save task"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to category_path(@task.category), notice: "Task updated successfully"
    else
      flash[:alert] = "Unable to save task"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to category_path(@task.category), notice: "Task deleted successfully"
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :due_date, :category_id)
  end

  def referer
    session[:return_to] = request.referer # Store the original referer
  end
end
