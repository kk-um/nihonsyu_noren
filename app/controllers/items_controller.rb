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
    begin
    @item = Item.find(params[:id])

    if @item.user_id == current_user.id
      @item.destroy
      redirect_to '/items'
    else
      redirect_to '/items'
      flash[:alert] = "他人の投稿は削除できません"
    end

    rescue ActiveRecord::RecordNotFound
      flash[:alert] = 'その投稿は存在しません'
      redirect_back(fallback_location: '/items')
    end
  end

  private
  # ストロングパラメータ
  def item_params
    params.require(:item).permit(:image, :name, :explanation, :price, genre_ids: [])
  end

end
