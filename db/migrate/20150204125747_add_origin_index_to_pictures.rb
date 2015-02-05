class AddOriginIndexToPictures < ActiveRecord::Migration
  def change
    add_index :pictures, :origin
  end
end
