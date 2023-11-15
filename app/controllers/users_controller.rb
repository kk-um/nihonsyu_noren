class UsersController < ApplicationController
  def show
    @user = current_user
    @items = @user.items
    @item = Item.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to user_path
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :email)
  end

end
