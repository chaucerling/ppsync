class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :user, null: false
      t.string :name, null: false
      t.string :origin, null: false

      t.timestamps null: false
    end
  end
end
