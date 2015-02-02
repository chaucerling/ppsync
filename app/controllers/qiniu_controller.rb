require 'net/http'

class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def callback
    res = {:success => "true" , :receive => params}.to_json
    picture = Picture.new
    picture.user_id = params[:user_id]
    picture.origin = params[:hash]
    picture.name = params[:name]
    if picture.save
      render json: res
    else
      render json: {:error => "can not save"}
    end
  end

  def callback2
    @res = {:success => "true" , :id => params[:user_id]}.to_json
    render json: @res
  end

  private
  def call_params
    params.permit(:name, :hash, :price, :location, :uid, :key, :imageInfo, :fsize)
  end
end
