class CategoriesController < ApplicationController
  before_action :set_category, only: [ :show, :edit, :update, :destroy ]
  def index
    @categories = current_user.categories
  end

  def show
    @tasks = @category.tasks
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to @category, notice: "Category created successfully"
    else
      flash[:alert] = "Unable to save category"
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: "Category updated successfully"
    else
      flash[:alert] = "Unable to save category"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Category deleted successfully"
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
