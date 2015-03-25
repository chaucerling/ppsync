class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :user, null: false
      t.string :name
      t.string :key, null: false
      t.text :info
      t.text :fetch
      t.text :thumbnail

      t.timestamps null: false
    end
    add_index :pictures, :key
  end
end
