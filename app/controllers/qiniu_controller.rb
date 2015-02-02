require 'net/http'

class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def callback
    res = {:success => "true" , :receive => params, :Authorization => request.authorization}.to_json
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
    render json: res.to_json()
  end

  private
  def pic_params
    params.permit(:name, :origin, :user_id)
  end
end
