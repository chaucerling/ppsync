class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  # if callback response fail, qiniu server will retry callback again
  def callback
    render json: {:error => "not from qiniu"} if !QiniuPicture.auth(request)
    picture = Picture.new(pic_params)
    picture.name = params[:fname] if picture.name.blank?
    #key = Digest::MD5.hexdigest(params[:etag] << Time.now.to_f.to_s)
    #picture.orgin = key
    picture.info = JSON.parse(params[:image_info])
    if picture.save
      res = {:success => "true" , :receive => params}
      render json: {:key => 'key', :payload => res}
    else
      res = {:error => "can not save"}
      render json: {:key => 'key', :payload => res}
      QiniuPicture.delete picture.origin
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
