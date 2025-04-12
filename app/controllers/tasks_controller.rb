class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, except: [ :index ]
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @tasks = current_user.tasks.includes(:category)
    @tasks_today = @tasks.where(due_date: Date.today)
    @upcoming_tasks = @tasks.where("due_date > ?", Date.today)
  end
  def show; end

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.new(task_params)

    if @task.save
      redirect_to category_task_path(@category, @task)
      flash[:notice] = "Task created successfully"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to category_path(@task.category)
      flash[:notice] = "Task updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to category_path(@task.category)
    flash[:notice] = "Task deleted successfully"
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
end