class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    @item.save
    redirect_to '/items'
  end
  
  def index
    @items = Item.all
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:image, :name, :explanation, :genre_id, :price)
  end
  
  
end
