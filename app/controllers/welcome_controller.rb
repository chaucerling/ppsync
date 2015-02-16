class WelcomeController < ApplicationController

  def index
    put_policy = Qiniu::Auth::PutPolicy.new("ppsync")
    #@put_policy.return_url="http://127.0.0.1:3000"
    put_policy.callback_url = "ppsync.herokuapp.com/qiniu/callback"
    put_policy.callback_body = "uid=123"
    @uptoken = Qiniu::Auth.generate_uptoken(put_policy)
  end

  def user
    @user = User.all
    render json: @user
  end

  def userprovider
    @user = UserProvider.all
    render json: @user
  end
end
