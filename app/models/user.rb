class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, 
    :omniauthable, :timeoutable, :timeout_in => 2.days
  has_many :pictures, inverse_of: :user, dependent: :destroy
  has_many :user_providers, inverse_of: :user, dependent: :destroy
  validates :nickname, presence: true
  after_find :modify_auth_email
  
  def timeout_in time
    time
  end

  protected
  def modify_auth_email
    if (self.mail =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i).nil?
      self.mail = ""
    end
  end
end
