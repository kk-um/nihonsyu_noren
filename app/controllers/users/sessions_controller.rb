class Users::SessionsController < Devise::SessionsController
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to items_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def new
  end

  def create
  end
end
