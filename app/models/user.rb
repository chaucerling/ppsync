class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
    :rememberable, :trackable, :validatable, :omniauthable
  has_many :pictures, inverse_of: :user, dependent: :destroy
  has_many :catalogs, inverse_of: :user, dependent: :destroy
  has_many :user_websites, inverse_of: :user, dependent: :destroy
  has_many :system_websites , through: :user_websites, dependent: :destroy
  has_many :user_provider, dependent: :destroy
  validates :nickname, presence: true
  after_create :create_default_catalog

  def self.from_omniauth(auth, current_user)
    user_provider = UserProvider.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    if user_provider.user
      return user_provider.user
    elsif current_user
      user_provider.user =  current_user
      user_provider.save
      return user_provider.user
    else
      user_provider.user =  User.new(nickname: auth.info.name).save(validate: false)
      user_provider.save
      return user_provider.user
    end
  end
  
  protected
  def create_default_catalog
    self.catalogs.create!(name: "default", user_id: self.id)
  end
end
