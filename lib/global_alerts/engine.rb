module GlobalAlerts
  class Engine < ::Rails::Engine
    isolate_namespace GlobalAlerts

    config.cache = nil #defaults to Rails.cache
    config.application_name = nil
    config.url = 'https://github.com/sul-dlss/global-alerts/raw/main/sul.yaml'

    initializer('global_alerts_default') do |app|
      # parent_name is deprecated in Rails 6.1
      config.application_name ||= app.class.respond_to?(:parent_name) ? app.class.parent_name.underscore : app.class.module_parent_name.underscore
    end
  end
end
