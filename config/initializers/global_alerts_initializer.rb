Rails.application.reloader.to_prepare do
  GlobalAlerts::Alert.cache.delete(GlobalAlerts::Alert::CACHE_KEY)
end
