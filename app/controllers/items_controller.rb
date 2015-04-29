class ItemsController < ApplicationController

  def index
    if params.has_key?(:category)
      @items = Category.find(params[:category][:category_id]).items
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