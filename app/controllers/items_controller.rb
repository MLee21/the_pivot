class ItemsController < ApplicationController

  def index
    @items ||= Item.all
  end

  def show
    @item = Item.unscoped.find(params[:id])
  end

  def create
  end
  
end