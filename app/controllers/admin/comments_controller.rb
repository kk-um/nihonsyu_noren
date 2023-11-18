class Admin::CommentsController < ApplicationController
  
  def index
    @comments = Comment.all
    @users = User.all
  end
  
  def destroy
    @comments = Comment.find(params[:id])
    @comments.destroy
    redirect_to request.referer
  end
end
