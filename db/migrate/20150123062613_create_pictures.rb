class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.belongs_to :user
      t.string :name
      t.string :origin_url

      t.timestamps null: false
    end
  end
end
