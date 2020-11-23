module GlobalAlerts
  class Engine < ::Rails::Engine
    isolate_namespace GlobalAlerts

    config.cache = nil #defaults to Rails.cache
    config.application_name = nil
    config.url = 'https://github.com/sul-dlss/global-alerts/raw/test/sul.yaml'

    initializer('global_alerts_default') do |app|
      config.application_name ||= app.class.parent_name.underscore
    end
  end
end
