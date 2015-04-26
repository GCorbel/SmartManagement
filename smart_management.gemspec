$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "smart_management/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "smart_management"
  s.version     = SmartManagement::VERSION
  s.authors     = ["GCorbel"]
  s.email       = ["guirec.corbel@gmail.com"]
  s.homepage    = "https://github.com/GCorbel/smart_management"
  s.summary     = "Easy way to build an administration part for a Rails application"
  s.description = %q{
    SmartManagement is designed to be simple to use and to customize.
    It allows to create a admin part for you Rails application in a few
    seconds.
  }
  s.license     = "MIT"

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.files += Dir["vendor/assets/javascripts/*"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "decent_exposure", "~> 2.3"
  s.add_dependency "responders", "~> 2.1"
  s.add_dependency "simple_form", "~> 3.1"
  s.add_dependency "angular_rails_csrf", "~> 1.0"
  s.add_dependency "twitter-bootstrap-rails", "~> 3.2"
  s.add_dependency "therubyracer", "~> 0.12"
  s.add_dependency "angularjs-rails", "~> 1.3"
  s.add_dependency "underscore-rails", "~> 1.8"
  s.add_dependency "less-rails", "~> 2.6"

  s.add_development_dependency "rspec-rails", "~> 3.2"
  s.add_development_dependency "capybara", "~> 2.4"
  s.add_development_dependency "capybara-webkit", "~> 1.3"
  s.add_development_dependency "database_cleaner", "~> 1.4"
end
