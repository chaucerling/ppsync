require 'net/http'


class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def callback
    ans = is_qiniu_callback request
    res = {:success => "true" , :receive => params, :ans => ans.to_s}
    #picture = Picture.new(pic_params)
    # if picture.save
    render json: res
    # else
    #   render json: {:error => "can not save"}.to_json
    # end
  end

  def callback2
    # data = JSON.parse '{"Authorization":"QBox QPg0_gqzPQPzZZCUm3Um6WxxwKluYzkxnxevc3cQ:edi7jur7xT4nD9dAyVKK22wsMi0=","ans":"false","body":"key=Fhd37hDn0ceptr-NR-1N3crsMANi\u0026origin=Fhd37hDn0ceptr-NR-1N3crsMANi\u0026fsize=410999\u0026imageInfo=%7B%22format%22%3A%22png%22%2C%22width%22%3A1100%2C%22height%22%3A750%2C%22colorModel%22%3A%22nrgba%22%7D\u0026name=12345\u0026user_id=1","query":"","receive":{"action":"callback","controller":"qiniu","fsize":"410999","imageInfo":"{\"format\":\"png\",\"width\":1100,\"height\":750,\"colorModel\":\"nrgba\"}","key":"Fhd37hDn0ceptr-NR-1N3crsMANi","name":"12345","origin":"Fhd37hDn0ceptr-NR-1N3crsMANi","user_id":"1"},"success":"true"}'
    # data =  URI.unescape data['body']
    # p key = Qiniu::Config.settings[:secret_key]
    # p Base64.urlsafe_encode64 Digest::HMAC.digest(data, key, Digest::SHA1)
    # p Base64.urlsafe_encode64 OpenSSL::HMAC.digest('sha1', key, data)
    res = {:success => "true" , :receive => params, :url =>request.path}
    render json: res
  end

  private
  def pic_params
    params.permit(:name, :origin, :user_id)
  end

  def is_qiniu_callback request
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
