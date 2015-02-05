class CreateUserWebsites < ActiveRecord::Migration
  def change
    create_table :user_websites  do |t|
      t.belongs_to :catalog, null: false
      t.belongs_to :user, null: false
      t.belongs_to :system_website, null: false
      t.belongs_to :picture, null: false
      t.string :picture_url, null: false
      t.integer :sync_id, null: false
      
      t.timestamps null: false
    end
    add_index :user_websites, ["user_id", "system_website_id"], :unique => true
  end
end
