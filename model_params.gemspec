$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "model_params/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "model_params"
  s.version     = ModelParams::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of ModelParams."
  s.description = "TODO: Description of ModelParams."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
