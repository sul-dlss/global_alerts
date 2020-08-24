Rails.application.routes.draw do
  mount GlobalAlerts::Engine => "/global_alerts"
end
