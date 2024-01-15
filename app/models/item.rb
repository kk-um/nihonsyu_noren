class Item < ApplicationRecord
  has_one_attached :image

  belongs_to :user
  has_many :likes, dependent: :destroy

  # 中間テーブルを経由してgenreを関連付けている
  has_many :item_genre_relations
  has_many :genres, through: :item_genre_relations
  has_many :comments, dependent: :destroy

  validates :name, presence: true

# 画像に関して
  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(gravity: :center, resize:"#{width}x#{height}^", crop:"#{width}x#{height}+0+0").processed
  end

  # いいね機能で使用↓
  def favorited_by?(user)
    #userがnilの場合falseで返す
    return false unless user.present?
    #likesテーブル内に、user_idが引数として渡されたユーザーのIDと一致し、item_idが自分のアイテムのIDと一致するレコードが存在するかどうかの
    likes.exists?(user_id: user.id)
  end

# 検索機能ransack
  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

end
