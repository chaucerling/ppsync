require 'net/http'

class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session

  def callback
    params[]
    @res = {:success => "true" , :id => params[:user_id]}.to_json
    render json: @res
  end

  def callback2
    @res = {:success => "true"}
    render json: @res
  end

  private
  def call_params
    params.permit(:name, :hash, :price, :location, :uid, :key, :imageInfo, :fsize, :user_id)
  end
end
