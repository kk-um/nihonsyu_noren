class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to '/items'
    else
      render :new
    end
  end

  def index
    @q = Item.ransack(params[:q])
      if params[:genre_id].present? #genre_idで検索したら
        @items = Genre.find(params[:genre_id]).items #genre_idで街頭するitemをとってくる
      elsif params[:q].present? #genre_idで検索してなくてransackで検索してたら
        @items = @q.result.includes(:user) #userの検索も含む結果を表示する
      else
        @items = Item.all.order(created_at: :desc) #上のどちらでもない時itemを全て表示する
      end
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
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
