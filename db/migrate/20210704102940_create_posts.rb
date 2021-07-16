class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id,     null: false
      t.integer :category_id, null: false
      t.string :place,        null: false
      t.text :introduction,   null: false
      t.string :image_id
      t.string :address,      null: false
      t.float :latitude,      null: false
      t.float :longitude,     null: false
      t.integer :dog_size,    null: false, default: 0
      t.boolean :report,      null: false,default: false

      t.timestamps
    end
  end
end
