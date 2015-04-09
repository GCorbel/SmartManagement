$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "smart_management/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "smart_management"
  s.version     = SmartManagement::VERSION
  s.authors     = ["GCorbel"]
  s.email       = ["guirec.corbel@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SmartManagement."
  s.description = "TODO: Description of SmartManagement."
  s.license     = "MIT"

  s.files = Dir["{app,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"
  s.add_dependency "decent_exposure"
  s.add_dependency "responders"
  s.add_dependency "simple_form"
  s.add_dependency "simple_form_angular"
  s.add_dependency "rabl"
  s.add_dependency "angular_rails_csrf"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "capybara-webkit"
  s.add_development_dependency "database_cleaner"
end
