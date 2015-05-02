class Admin::ItemsController < Admin::BaseController
  before_action :ensure_admin_user
  
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      flash[:error] = @item.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = 'Item successfully updated'
      redirect_to items_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :image, category_ids: [])
  end

end
