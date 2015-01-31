require 'net/http'

class QiniuController < ApplicationController
  skip_before_action :authenticate_user!
  protect_from_forgery with: :null_session    

  def callback
    @res = {:success => "true"}.to_json
    render json: @res
  end

  def callback2
    @res = {:success => "true"}
    render json: @res
  end

  private
  def call_params
    params.permit(:name, :hash, :price, :location, :uid)
  end
end
