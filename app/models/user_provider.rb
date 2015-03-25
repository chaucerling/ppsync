class UserProvider < ActiveRecord::Base
  # t.integer  "user_id",     null: false
  # t.integer  "provider_id", null: false
  # t.string   "uid",         null: false
  # t.string   "token"        null: false
  # t.string   "picture_url", null: false
  # t.integer  "sync_id"
  # t.datetime "created_at",  null: false
  # t.datetime "updated_at",  null: false

  belongs_to :user, inverse_of: :user_providers
  belongs_to :provider, inverse_of: :user_providers
  validates :provider, :uid, :user, :token, :picture_url, presence: true


  def self.from_omniauth(auth, current_user)
    provider_id = Provider.get_id(auth.provider)
    user_provider = UserProvider.find_or_initialize_by(provider: provider_id, uid: auth.uid)
    if current_user.blank?
      return nil
    elsif user_provider.new_record?
      user_provider.user = current_user
      user_provider.update_and_save_auth(auth)
      return current_user
    elsif user_provider.user.eql?(current_user)
      user_provider.update_and_save_auth(auth)
      return current_user
    else
      return nil
    end
  end

  def update_and_save_auth(auth)
    slef.update_auth_image(auth)
    self.token = auth.credentials.token
    self.save
    #user.timeout_in (auth.credentials.expires_at - Time.now.to_i).second
  end

  def update_auth_image(auth)
    if self.picture_url != auth.image
      Picture.fetch(auth.image, self.user.id)
      self.picture_url = auth.image
      self.save
    end
  end

end