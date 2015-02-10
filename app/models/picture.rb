class Picture < ActiveRecord::Base
  # Serialize preferences as Hash using YAML coder
  serialize :info, Hash
  serialize :thumbnail, Hash
  # association
  belongs_to :user, inverse_of: :pictures
  has_many :user_websites, inverse_of: :picture
  validates :name, :origin, :user, presence: true
  #callback function
  after_destroy :delete_in_qiniu

  def origin_url
    "#{Qiniu::Config.settings[:domain]}/#{self.origin}"
  end

  protected
  def delete_in_qiniu 
    if Picture.find_by(orgin: self.origin) == nil
      QiniuPicture.delete self.origin
    end
  end
end
