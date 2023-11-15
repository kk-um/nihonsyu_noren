class RenamePostIdColumToLikes < ActiveRecord::Migration[6.1]
  def change
    rename_column :likes, :post_id, :item_id
    change_column :likes, :item_id, :integer, null: false
  end
end
