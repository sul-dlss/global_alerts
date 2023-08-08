require 'test_helper'

class GlobalAlerts::Alert::Test < ActiveSupport::TestCase
  test "it defaults to the current time" do
    assert_in_delta Time.zone.now, GlobalAlerts::Alert.global_alert_time, 1
  end

  test "it can be set explicitly" do
    t = Time.zone.now - 1.day
    GlobalAlerts::Alert.global_alert_time = t

    assert_equal t, GlobalAlerts::Alert.global_alert_time

    GlobalAlerts::Alert.global_alert_time = nil
  end
end
