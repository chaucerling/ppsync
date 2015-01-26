class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_many :pictures 
  has_many :catalogs
  has_many :user_websites
  has_many :system_websites , through: :user_websites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
    :rememberable, :trackable, :validatable
end
