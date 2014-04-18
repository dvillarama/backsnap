require 'settingslogic'

module Backsnap
  class Settings < Settingslogic
    source ::File.expand_path(::File.join(::File.dirname(__FILE__), '..','..', 'config', 'settings.yml'))
    load!
  end
end
