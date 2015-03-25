class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :providers, :name
  end
end
