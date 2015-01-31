class UserWebsite < ActiveRecord::Base
  self.primary_keys = :user_id, :system_website_id
  belongs_to :user
  belongs_to :system_website
  belongs_to :catalog
  belongs_to :picture
end
