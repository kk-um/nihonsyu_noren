class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_one_attached :profile_image

# ログイン可能かのメソッド
  def active_for_authentication?
    super && (self.is_active === true)
  end

# 停止中のアカウントへのエラーメッセージ
  def inactive_message
    active_for_authentication? ? super : I18n.t('flash_message.inactive_user')
  end


# ゲストユーザー
GUEST_USER_EMAIL = "guest@example.com"
  def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "ゲスト"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
# ---

# プロ画表示
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/user.png')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end

# ユーザ名、アイテム名で検索できる
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
  
  def self.ransackable_associations(auth_object = nil)
    ["items"]
  end
  
end
