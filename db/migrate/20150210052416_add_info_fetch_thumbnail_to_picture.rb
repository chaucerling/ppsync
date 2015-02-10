class AddInfoFetchThumbnailToPicture < ActiveRecord::Migration
  def change
    add_column :pictures, :info, :text, null: false
    add_column :pictures, :fetch, :string
    add_column :pictures, :thumbnail, :text
  end
end
