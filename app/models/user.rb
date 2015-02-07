class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
    :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  #mount_uploader :avatar, AvatarUploader
  has_many :pictures, inverse_of: :user, dependent: :destroy
  has_many :catalogs, inverse_of: :user, dependent: :destroy
  has_many :user_websites, inverse_of: :user, dependent: :destroy
  has_many :system_websites , through: :user_websites, dependent: :destroy

  validates :username, :presence => true, :uniqueness => {:case_sensitive => false}, length: {minimum: 4}

  attr_accessor :login
  after_create :create_default_catalog

  # devise: use username & email to login
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
       # when allowing distinct User records with, e.g., "username" and "UserName"...
       # where(conditions).where(["username = :value OR lower(email) = lower(:value)", { :value => login }]).first
    else
      where(conditions.to_h).first
    end
  end

  protected
  def create_default_catalog
    self.catalogs.create(name: "default", user_id: self.id)
  end
end
