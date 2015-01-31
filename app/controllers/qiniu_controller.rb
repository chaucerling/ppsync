require 'net/http'

class QiniuController < ApplicationController
  skip_before_action :authenticate_user!

  def callback
    p call_params
    @res = {:success => "true", :name => "sunflowerb.jpg"}.to_json
    render layout: false
  end

  private
  def call_params
    params.permit(:name, :hash, :price, :location, :uid)
  end
end
