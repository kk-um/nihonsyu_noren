class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.integer :genre_id,null: false
      t.string :name,null: false
      t.integer :price
      t.text :explanation
      
      t.timestamps
    end
  end
end
