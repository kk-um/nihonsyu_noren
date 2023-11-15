class RenamePostIdColumnToComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :comments, :post_id, :item_id
    change_column :comments, :item_id, :integer, null: false
  end
end
