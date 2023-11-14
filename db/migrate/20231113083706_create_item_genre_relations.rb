class CreateItemGenreRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :item_genre_relations do |t|
      
      t.integer :item_id,null: false
      t.integer :genre_id,null: false
      
      t.timestamps
    end
  end
end
