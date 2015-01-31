class Catalog < ActiveRecord::Base
  belongs_to :user
  has_many :user_websites
end
