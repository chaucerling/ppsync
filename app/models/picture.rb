class Picture < ActiveRecord::Base
  #mount_uploader :origin , AvatarUploader
  belongs_to :user, inverse_of: :picture
  has_many :user_websites, inverse_of: :picture
  validates :name, :origin, :user, presence: true

  after_destroy :delete_in_qiniu

  def origin_url
    "7u2s6m.com1.z0.glb.clouddn.com/#{self.origin}"
  end

  def self.domain
    "7u2s6m.com1.z0.glb.clouddn.com"
  end

  protected
  def delete_in_qiniu 
    if Picture.find_by(orgin: self.origin) == nil
      code, result, response_headers = Qiniu::Storage.delete("ppsync", self.origin)
      puts code.inspect
      puts result.inspect
      puts response_headers.inspect
    end
  end
end
