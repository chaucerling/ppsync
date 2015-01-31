class CreateSystemWebsites < ActiveRecord::Migration
  def change
    create_table :system_websites do |t|
      t.string :name
      t.string :type
      t.string :url

      t.timestamps null: false
    end
  end
end
