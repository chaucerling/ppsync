require 'qiniu'

Qiniu.establish_connection! :access_key => 'QPg0_gqzPQPzZZCUm3Um6WxxwKluYzkxnxevc3cQ',
                                            :secret_key => 'wlZaFm2eEj2SdQB0SpRVPcI71G-kpuc0bBPfO0-7'

Qiniu::Config.settings[:domain] = "7u2s6m.com1.z0.glb.clouddn.com"
Qiniu::Config.settings[:bucket] = "ppsync"