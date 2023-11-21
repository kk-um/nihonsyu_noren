class Users::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create]
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to items_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  
  def new
  end

  def create
  end
  
  protected
  
# 退会しているかを判断するメソッド
  def customer_state
    # 入力されたemailからアカウントを1件取得
    @user = User.find_by(email: params[:user][:email])
    if @user
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
      if @user.valid_password?(params[:user][:password]) && !@user.is_active
      #一致してるかつ退会してたら（!〇〇.is_active=有効状態の反転）
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      else
          flash[:notice] = "項目を入力してください"
      end
    end

  end

end
