class UsersController < ApplicationController
  before_action :ensure_guest_user, only: [:edit]
  before_action :is_matching_login_user, only: [:edit, :update]

  def show
    @user = current_user
    @items = @user.items.order(created_at: :desc)
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
    @user.destroy
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

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

  def user_params
    params.require(:user).permit(:profile_image, :name, :email)
  end

end
