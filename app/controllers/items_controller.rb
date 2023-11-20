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
    @items = params[:genre_id].present? ? Genre.find(params[:genre_id]).items : Item.all
    @q = Item.ransack(params[:q])
    @items = @q.result.includes(:user)
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to '/items'
  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:image, :name, :explanation, :price, genre_ids: [])
  end


end
