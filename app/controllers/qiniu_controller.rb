require 'net/http'
require 'openssl'

class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def callback
    ans = is_qiniu_callback request
    res = {:success => "true" , :receive => params, :Authorization => request.authorization, :ans => ans.to_s}.to_json
    #picture = Picture.new(pic_params)
    # if picture.save
    render json: res
    # else
    #   render json: {:error => "can not save"}.to_json
    # end
  end

  def callback2
    res = {:success => "true" , :receive => params, :header => request.authorization}
    p headers
    p request.authorization
    key = Qiniu::Config.settings[:secret_key]
    data = "1234"
    p hmac = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, key, data)
    render json: res.to_json()
  end

  private
  def pic_params
    params.permit(:name, :origin, :user_id)
  end

  def is_qiniu_callback request
    #example "Authorization":"QBox QPg0_gqzPQPzZZCUm3Um6WxxwKluYzkxnxevc3cQ:edi7jur7xT4nD9dAyVKK22wsMi0="
    auth_str = request.authorization
    auth_arr = auth_str[5..-1].split(":")
    data = request.raw_post
    key = Qiniu::Config.settings[:secret_key]
    if !auth_str.include?("QBox ") || auth_arr.size != 2 || auth_arr[0] != Qiniu::Config.settings[:access_key] || 
      auth_arr[1] != OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA1.new, key, data) 
      return false
    else 
      return true
    end
  end
end
