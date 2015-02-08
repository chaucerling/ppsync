class QiniuPicture
  def self.uptoken
    put_policy = Qiniu::Auth::PutPolicy.new(Qiniu::Config.settings[:bucket])
    # can not override the same key file
    put_policy.insert_only = 1
    # error code 413
    put_policy.fsize_limit = 5 * 1024
    # image only, error code 403
    put_policy.mime_limit = "image/*"
    # set key by callback result
    put_policy.callback_fetch_key = 1
    put_policy.callback_url = "ppsync.herokuapp.com/qiniu/callback"
    # params
    put_policy.callback_body = "key=$(key)&origin=$(etag)&fname=$(fname)&fsize=$(fsize)&imageInfo=$(imageInfo)
    &name=$(x:picname)&user_id=#{current_user.id}"
    # upload_token
    return Qiniu::Auth.generate_uptoken(put_policy)   
  end

  def self.delete key
    code, result, response_headers = Qiniu::Storage.delete(Qiniu::Config.settings[:bucket], key)
    # puts code.inspect
    # puts result.inspect
    # puts response_headers.inspect
    return  code, result, response_headers
  end

  #authenticate qiniu callback
  #Authorization:QBox iN7NgwM31j4-BZacMjPrOQBs34UG1maYCAQmhdCV:tDK-3f5xF3SJYEAwsll5g=
  #acctoken = "#{access_key}:#{encoded_sign}"
  def self.auth request
    acctoken = Qiniu::Auth.generate_acctoken(request.path, request.raw_post)
    return request.authorization.eql?("QBox #{acctoken}")
    # auth_str = request.authorization
    # return false if auth_str == nil || auth_str.length < 6
    # auth_arr = auth_str[5..-1].split(":")
    # key = Qiniu::Config.settings[:secret_key]
    # if auth_str.include?("QBox ") && auth_arr.size == 2 && auth_arr[0].eql?(Qiniu::Config.settings[:access_key]) &&
    #   (auth_arr[1].eql? Base64.urlsafe_encode64 OpenSSL::HMAC.digest("sha1", key, url))
    #   return true
    # else 
    #   return false
    # end
  end

  def self.fetch fetch_url
    encoded_url =Base64.urlsafe_encode64 fetch_url
    encoded_entry_uri = Base64.urlsafe_encode64("#{Qiniu::Config.settings[:bucket]}:fetch#{Time.now}")
    url = "http://iovip.qbox.me/fetch/#{encoded_url}/to/#{encoded_entry_uri}"
    acctoken = Qiniu::Auth.generate_acctoken(url)
    # send post request
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.path)
    request["Authorization"] = "QBox #{acctoken}" 
    request["Content-Type"] = "application/x-www-form-urlencoded"
    #request.body = body
    response = http.request(request)
  end
end