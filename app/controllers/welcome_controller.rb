class WelcomeController < ApplicationController

  def index
    put_policy = Qiniu::Auth::PutPolicy.new("ppsync")
    #@put_policy.return_url="http://127.0.0.1:3000"
    put_policy.callback_url = "https://ppsync.herokuapp.com/qiniu/callback"
    put_policy.callback_body = "name=$(fname)&hash=$(etag)&location=$(x:location)&price=$(x:price)&uid=123"
    @uptoken = Qiniu::Auth.generate_uptoken(put_policy)
  end
end
