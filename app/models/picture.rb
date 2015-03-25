class Picture < ActiveRecord::Base

  # t.belongs_to :user, null: false
  # t.string :name
  # t.string :key, null: false
  # t.text :info
  # t.text :fetch
  # t.text :thumbnail

  # Serialize preferences as Hash using YAML coder
  serialize :info, Hash
  serialize :thumbnail, Hash
  # association
  belongs_to :user, inverse_of: :pictures
  validates :name, :key, :user, presence: true
  #callback function
  after_destroy :delete_in_qiniu

  def origin_url
    "#{Qiniu::Config.settings[:domain]}/#{self.key}"
  end

  def self.new_from_callback params
    picture = Picture.new do
      picture.name = params[:name] || params[:fname] ||Time.now.strftime("%Y%m%d%H%M%S")
      picture.key = params[:key]
      picture.user_id = params[:user_id]
      picture.info = JSON.parse(params[:image_info]
      picture.fetch_str = "user"
    end
    picture.save
  end

  def self.fetch(picture_url, user_id, name = nil)
    response, key, info = QiniuPicture.fetch :picture_url
    if response.code.to_i == 200
      fetch_str = "system::#{URI.parse(picture_url).host}"
      name ||= Time.now.strftime("%Y%m%d%H%M%S")
      picture = Picture.create(key: key, user_id: user_id, name: name, fetch: fetch_str, info: info)
    else
      nil
    end
  end

  protected
  def delete_in_qiniu 
    if Picture.find_by(orgin: self.key) == nil
      QiniuPicture.delete self.key
    end
  end
end
