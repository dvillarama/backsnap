
module Backsnap
:q
:w
:q
  AWS.config({
    :access_key_id => Settings.aws['key'],
    :secret_access_key => Settings.aws['secret']
  })
end
