$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "cul_hydra_models/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "cul_hydra_models"
  s.version     = CulHydraModels::VERSION
  s.authors     = ["Eric O'Hanlon"]
  s.email       = ["elo2112@columbia.edu"]
  s.homepage    = "https://github.com/cul/cul_hydra_models"
  s.summary     = "Hydra models for CUL repository apps"
  s.description = "Hydra models for CUL repository apps."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 5.1.1"
  s.add_dependency('active-fedora', '~> 8.0')

  s.add_development_dependency "sqlite3"
end
