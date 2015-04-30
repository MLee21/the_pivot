class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'Category successfully updated'
      redirect_to admin_categories_path
    else
      flash[:error] = @category.errors.full_messages.join(', ')
      render :edit
    end
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category successfully created"
      redirect_to admin_categories_path
    else
      flash[:error] = @category.errors.full_messages.join(", ")
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end