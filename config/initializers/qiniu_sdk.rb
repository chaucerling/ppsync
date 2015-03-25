require 'qiniu'

Qiniu.establish_connection! :access_key => ENV['QINIU_KEY'], :secret_key => ['QINIU_SECRET']

Qiniu::Config.settings[:domain] = ENV['QINIU_DOMAIN']
Qiniu::Config.settings[:bucket] = ENV['QINIU_BUCKET']
Qiniu::Config.settings[:callback_url] = ENV['QINIU_CALLBACK_URL']