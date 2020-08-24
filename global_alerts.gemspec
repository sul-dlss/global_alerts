$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "global_alerts/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "global_alerts"
  spec.version     = GlobalAlerts::VERSION
  spec.authors     = ["Chris Beer"]
  spec.email       = ["cabeer@stanford.edu"]
  spec.homepage    = "TODO"
  spec.summary     = "SUL global alerts as a service"
  spec.license     = "Apache 2.0"

  spec.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 5.0" , "< 7"
  spec.add_dependency "http"

  spec.add_development_dependency "sqlite3"
end
