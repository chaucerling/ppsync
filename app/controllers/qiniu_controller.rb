require 'net/http'

class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def callback
    ans = is_qiniu_callback request
    res = {:success => "true" , :receive => params, :ans => ans.to_s}
    picture = Picture.new(pic_params)
    picture.name = params[:fname] if picture.name == nil
    if ans && picture.save
      render json: res
    else
      render json: {:error => "can not save"}
    end
  end

  def callback2
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
