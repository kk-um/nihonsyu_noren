class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = current_user
    @items = @user.items
    # @item = Item.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path
  end

  def confirm
    @user = User.find(current_user.id)
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end
  
  private

  def ensure_guest_user
      @user = User.find(params[:id])
      if @user.guest_user?
        redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
  end  

  def user_params
    params.require(:user).permit(:profile_image, :name, :email)
  end

end
