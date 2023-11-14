class Genre < ApplicationRecord
  # 中間テーブルを経由してitemを関連付けている
  has_many :item_genre_relations
  has_many :items, through: :item_genre_relations
end
