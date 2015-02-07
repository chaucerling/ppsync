class SystemWebsite < ActiveRecord::Base
  has_many :user_websites, inverse_of: :system_website
  has_many :users, through: :user_websites
  validates :name, presence: true
end
