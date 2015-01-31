class RenameTypeInSystemWebsite < ActiveRecord::Migration
  def change
    change_table :system_websites do |t|
      t.rename :type, :picture_type
    end
  end
end
