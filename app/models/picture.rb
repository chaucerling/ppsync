class Picture < ActiveRecord::Base
  #mount_uploader :origin , AvatarUploader
  belongs_to :user
  has_many :user_websites
end
