class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      
      t.integer :user_id,null: false
      t.integer :item_id,null: false
      t.string :star,null: false
      t.boolean :is_active,null: false, default: true
      
      t.timestamps
    end
  end
end
