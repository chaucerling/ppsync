class UserProvider < ActiveRecord::Base
  belongs_to :user, inverse_of: :user_provider
  validates :provider, :uid, :user, presence: true
end