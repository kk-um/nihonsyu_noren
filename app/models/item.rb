class Item < ApplicationRecord
  has_one_attached :image
  
  belongs_to :user
  has_many :likes, dependent: :destroy
  
  # 中間テーブルを経由してgenreを関連付けている
  has_many :item_genre_relations
  has_many :genres, through: :item_genre_relations
  has_many :comments, dependent: :destroy

  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end
  
  # いいね機能で使用↓
  def favorited_by?(user)
    likes.exists?(user_id: user.id)
  end
  
  
end
