$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "model_attributes/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "model_attributes"
  s.version     = ModelAttributes::VERSION
  s.authors     = ["Ababii Alexandr"]
  s.email       = ["work.maki.5@gmail.com"]
  s.homepage    = "https://github.com/maki5/model_attributes"
  s.summary     = "Add model attributes description."
  s.description = "Add model attributes description for rails 4"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  s.license = 'MIT'

  s.add_dependency "rails", "~> 4.0.0"
end
