class CreateUserProviders < ActiveRecord::Migration
  def change
    create_table :user_providers do |t|
      t.belongs_to :user, null: false
      t.belongs_to :provider, null: false
      #t.string :provider, null: false
      t.string :uid, null: false
      t.string :token, null: false
      t.string :picture_url, null: false

      t.timestamps null: false
    end
  end
end
