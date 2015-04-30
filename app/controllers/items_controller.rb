class ItemsController < ApplicationController

  def index
    if params.has_key?(:category)
      category = Category.find(params[:category][:id])
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