class UserWebsite < ActiveRecord::Base
  self.primary_keys = :user_id, :system_website_id
  belongs_to :user, inverse_of: :user_websites
  belongs_to :system_website, inverse_of: :user_websites
  belongs_to :catalog, inverse_of: :user_websites
  belongs_to :picture, inverse_of: :user_websites
  validates :user, :system_website, :catalog, :picture, presence: true
end
