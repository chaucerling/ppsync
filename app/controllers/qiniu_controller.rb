require 'net/http'

class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def callback
    ans = QiniuPicture.auth request
    render json: {:error => "not from qiniu"} if !ans
    render json: {:error => "upload error"} if params[:orgin] == nil
    picture = Picture.new(pic_params)
    picture.name = params[:fname] if picture.name.blank?
    if picture.save
      render json: {:success => "true" , :receive => params, :ans => ans.to_s}
    else
      QiniuPicture.delete picture.origin
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
end
