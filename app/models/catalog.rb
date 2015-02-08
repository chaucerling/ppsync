class Catalog < ActiveRecord::Base
  belongs_to :user, inverse_of: :catalogs
  has_many :user_websites, inverse_of: :catalog
  validates :name, :user, presence: true
end
