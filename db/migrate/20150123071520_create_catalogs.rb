class CreateCatalogs < ActiveRecord::Migration
  def change
    create_table :catalogs do |t|
      t.belongs_to :user
      t.string :name

      t.timestamps null: false
    end
  end
end
