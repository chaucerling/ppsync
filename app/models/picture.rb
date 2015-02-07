class Picture < ActiveRecord::Base
  belongs_to :user, inverse_of: :picture
  has_many :user_websites, inverse_of: :picture
  validates :name, :origin, :user, presence: true

  after_destroy :delete_in_qiniu

  def origin_url
    "#{Qiniu::Config.settings[:domain]}/#{self.origin}"
  end

  def self.domain
    Qiniu::Config.settings[:domain]
  end

  protected
  def delete_in_qiniu 
    if Picture.find_by(orgin: self.origin) == nil
      QiniuPicture.delete self.origin
    end
  end
end
