class CreateUserWebsites < ActiveRecord::Migration
  def change
    create_table :user_websites  do |t|
      t.belongs_to :catalog
      t.belongs_to :user
      t.belongs_to :system_website
      t.belongs_to :picture
      t.string :picture_url
      t.integer :sync_id
      
      t.timestamps null: false
    end
    add_index :user_websites, ["user_id", "system_website_id"], :unique => true
  end
end
