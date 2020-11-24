# GlobalAlerts
A gem for managing user-facing alerts across the portfolio. 
⚠️[See current alerts](https://github.com/sul-dlss/global_alerts/blob/main/sul.yaml)

## Usage

### Consuming

- Add the gem
- Set GLOBAL_ALERTS to `<%= true %>` in the application settings.
- Set any engine configuration in the consuming application's initializers:
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

### Example Alerts

#### Basic alert
```
alerts:
   - html: A single <em>sample alert</em> across all apps. This will appear until manually removed from the YML file.
```

#### `to`
```
alerts:
   - to: '2020-12-07T12:00:00-07:00'
     html: This message will appear immediately and will expire on December 7th at noon.
```

#### `from`
```
alerts:
   - from: '2020-12-07T12:00:00-07:00'
     html: This message will begin on December 7th at noon and must be manually removed.
```
#### `from` and `to`
```
alerts:
   - from: '2020-12-24T12:00:00-07:00'
     to: '2020-12-25T12:00:00-07:00'
     html: This message will appear from December 24th at noon and expire on December 25th at noon. This YML should be removed later.
```

#### `application_name`
```
alerts:
   - application_name: 'MyLibrary
     html: This message will appear on MyLibrary until manually removed.
   - html: This alert will appear on all other applications with GLOBAL_ALERTS enabled
```


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
