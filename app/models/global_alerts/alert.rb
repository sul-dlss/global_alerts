module GlobalAlerts
  class Alert
    include ActiveModel::Model

    CACHE_KEY = 'global-alerts'

    def self.all
      return to_enum(:all) unless block_given?

      data = cache.fetch(CACHE_KEY) do
        HTTP.get(GlobalAlerts::Engine.config.url).body
      end

      JSON.parse(data).each do |json|
        yield new(json)
      end
    rescue
      []
    end

    def self.first
      all.first
    end

    def self.cache
      GlobalAlerts::Engine.config.cache || Rails.cache
    end

    attr_accessor :html

    delegate :present?, to: :html

    def as_html
      html.html_safe
    end
  end
end
