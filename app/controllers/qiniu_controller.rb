class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  # if callback response fail, qiniu server will retry callback again
  def callback
    render json: {:error => "not from qiniu"} if !QiniuPicture.auth(request)

    if Picture.create_from_callback(params)
      res = {:success => "true" , :receive => params}
      render json: {:key => 'key', :payload => res}
    else
      res = {:error => "can not save"}
      render json: {:key => 'key', :payload => res}
      QiniuPicture.delete picture.key
    end
  end

  def callback2
    res = {:success => "true" , :receive => params, :url =>request.path}
    render json: res
  end

end
