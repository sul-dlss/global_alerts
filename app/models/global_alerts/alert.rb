require 'http'

module GlobalAlerts
  class Alert
    include ActiveModel::Model

    CACHE_KEY = 'global-alerts'
    ATTRIBUTES = %w[id dismiss html from to application_name].freeze

    def self.global_alert_time
      @global_alert_time || Time.zone.now
    end

    def self.global_alert_time=(time)
      @global_alert_time = time
    end

    def self.data(url: GlobalAlerts::Engine.config.url)
      body = cache.fetch([CACHE_KEY, url.hash].join('-')) do
        HTTP.follow.get(url).body.to_s
      end

      YAML.safe_load(body)
    end

    def self.all(**kwargs)
      return to_enum(:all) unless block_given?

      data(**kwargs).dig('alerts')&.each do |yaml|
        yield new(**yaml.slice(*ATTRIBUTES), other_attributes: yaml.except(*ATTRIBUTES))
      end
    rescue => e
      Rails.logger.warn(e)
      raise(e) if Rails.env.development?

      []
    end

    def self.active(time = GlobalAlerts::Alert.global_alert_time)
      active_alert = all.find do |alert|
        alert.active?(time: time, for_application: GlobalAlerts::Engine.config.application_name)
      end

      active_alert ||= all.find do |alert|
        alert.active?(time: time)
      end

      active_alert
    end

    def self.cache
      GlobalAlerts::Engine.config.cache || Rails.cache
    end

    attr_accessor(*ATTRIBUTES)
    attr_accessor :other_attributes

    delegate :present?, to: :html

    def active?(time: Time.zone.now, for_application: nil)
      return false if for_application != application_name

      return true if from.nil? && to.nil?

      range.cover?(time)
    end

    def range
      start_of_range = from.presence && Time.zone.parse(from)
      start_of_range ||= Time.at(0) unless RUBY_VERSION > '2.7'

      end_of_range = to.presence && Time.zone.parse(to)
      start_of_range...end_of_range
    end

    def as_html
      html.html_safe
    end
  end
end
