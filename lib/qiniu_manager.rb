class QiniuPicture
  def self.upload
    put_policy = Qiniu::Auth::PutPolicy.new(Qiniu::Config.settings[:bucket])
    put_policy.fsize_limit = 5 * 1024   #error code 413
    put_policy.mime_limit = "image/*"    #image only, error code 403
    put_policy.callback_url = "ppsync.herokuapp.com/qiniu/callback"
    put_policy.callback_body = "key=$(key)&origin=$(etag)&fname=$(fname)&fsize=$(fsize)&imageInfo=$(imageInfo)
    &name=$(x:picname)&user_id=#{current_user.id}"
    return Qiniu::Auth.generate_uptoken(put_policy)
  end

  def self.delete key
    code, result, response_headers = Qiniu::Storage.delete(Qiniu::Config.settings[:bucket], key)
    puts code.inspect
    puts result.inspect
    puts response_headers.inspect
  end

  #authenticate qiniu callback
  def self.auth request
    auth_str = request.authorization
    return false if auth_str == nil || auth_str.length < 6
    auth_arr = auth_str[5..-1].split(":")
    data = "#{request.path}\n#{request.raw_post}"
    key = Qiniu::Config.settings[:secret_key]
    if auth_str.include?("QBox ") && auth_arr.size == 2 && auth_arr[0].eql?(Qiniu::Config.settings[:access_key]) &&
      (auth_arr[1].eql? Base64.urlsafe_encode64 OpenSSL::HMAC.digest("sha1", key, data))
      return true
    else 
      return false
    end
  end
end