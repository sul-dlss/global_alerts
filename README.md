# GlobalAlerts
Short description and motivation.

## Usage

### Consuming

- Add the gem
- Set any engine configuration:
   - GlobalAlerts::Engine.config.cache (Cache for the alerts feed; defaults to the Rails cache)
   - GlobalAlerts::Engine.config.application_name (Used for app-specific alerts, default is derived from the application name)
   - GlobalAlerts::Engine.config.url (URL to pull alerts from)
- Render the global_alerts/alerts partial

### Publishing alerts

In a YAML file (e.g. https://github.com/sul-dlss/global_alerts/blob/main/sul.yaml by default), configure alerts using:

- `html`: the HTML-safe alert text
- `application_name`: used for application-specific alert text; matches against the consumer's `GlobalAlerts::Engine.config.application_name`
- `from`/`to`: schedule alerts for particular times (also supports open-ended ranges with only `from` or only `to`)

Consuming applications will pick only the first relevant alert.

Restart any consuming applications.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'global_alerts'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install global_alerts
```

## Contributing
Contribution directions go here.
