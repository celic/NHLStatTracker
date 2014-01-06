$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "deep_whale/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "Deep Whale"
  s.version     = DeepWhale::VERSION
  s.authors     = ["Andrew Rempe","Chris Celi"]
  s.email       = ["andrewrempe@gmail.com", "cceli@codequarry.net"]
  s.description = "Pulls stats from NHL.com."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end