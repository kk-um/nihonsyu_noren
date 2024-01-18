class Items::CommentsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    comment = current_user.comments.new(comment_params)
    comment.item_id = item.id
    if comment.save
      redirect_to item_path(item)
    else
      @item = item
      @comment = comment
      render 'items/show'
    end
  end

  def destroy
    item = Item.find(params[:item_id])
    comment = Comment.find(params[:id])
    
    if comment.user_id == current_user.id
      Comment.find(params[:id]).destroy
      redirect_to item_path(item)
    else
      redirect_to item_path(item)
      flash[:alert] = "他人の投稿は削除できません"
    end

  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
