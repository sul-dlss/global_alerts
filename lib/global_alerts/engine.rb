module GlobalAlerts
  class Engine < ::Rails::Engine
    isolate_namespace GlobalAlerts

    config.blah = 'bootstrap4'
    config.cache = nil
    config.url = 'http://example.com'
  end
end
