class ItemGenreRelation < ApplicationRecord
  belongs_to :item
  belongs_to :genre
end
