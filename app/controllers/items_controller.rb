class ItemsController < ApplicationController

  def index
    if params[:category][:category_id]
      category = Category.find(params[:category][:category_id])
      @items = category.items
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
  end
end