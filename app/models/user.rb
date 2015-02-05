class User < ActiveRecord::Base
  #mount_uploader :avatar, AvatarUploader
  has_many :pictures, inverse_of: :user
  has_many :catalogs, inverse_of: :user
  has_many :user_websites, inverse_of: :user
  has_many :system_websites , through: :user_websites
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
    :rememberable, :trackable, :validatable

  after_create :create_default_catalog

  protected
  def create_default_catalog
    self.catalogs.create(name: "default", user_id: self.id)
  end
end
