class Catalog < ActiveRecord::Base
  belongs_to :user, inverse_of: :catalog
  has_many :user_websites, inverse_of: :catalog
end
