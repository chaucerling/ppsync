class CreateSystemWebsites < ActiveRecord::Migration
  def change
    create_table :system_websites do |t|
      t.string :name, null: false
      t.string :picture_type
      t.string :url

      t.timestamps null: false
    end
  end
end
