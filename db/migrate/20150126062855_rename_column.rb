class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :pictures, :origin_url, :origin
  end
end
