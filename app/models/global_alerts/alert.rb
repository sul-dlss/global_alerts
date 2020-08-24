module GlobalAlerts
  class Alert
    include ActiveModel::Model

    CACHE_KEY = 'global-alerts'

    def self.all
      return to_enum(:all) unless block_given?

      body = cache.fetch(CACHE_KEY) do
        # HTTP.follow.get(GlobalAlerts::Engine.config.url).body.to_s
        File.read(GlobalAlerts::Engine.root + 'sul.yaml')
      end

      data = YAML.safe_load(body)
      data&.each do |yaml|
        yield new(yaml)
      end
    rescue => e
      Rails.logger.warn(e)
      raise(e) if Rails.env.development?

      []
    end

    def self.active(time = Time.zone.now)
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

    attr_accessor :html, :from, :to, :application_name

    delegate :present?, to: :html

    def active?(time: Time.zone.now, for_application: nil)
      return false if for_application == application_name

      return true if from.nil? && to.nil?
      ((from.presence && Time.zone.parse(from))...(to.presence && Time.zone.parse(to))).cover?(time)
    end

    def as_html
      html.html_safe
    end
  end
end
