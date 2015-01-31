class WelcomeController < ApplicationController

  def index
    @put_policy = Qiniu::Auth::PutPolicy.new("ppsync")
    @put_policy.return_url="http://127.0.0.1:3000"
    @uptoken = Qiniu::Auth.generate_uptoken(@put_policy)
  end
end
