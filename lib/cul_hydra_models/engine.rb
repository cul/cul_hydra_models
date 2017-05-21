module CulHydraModels
  class Engine < ::Rails::Engine
    isolate_namespace CulHydraModels

    config.generators do |g|
      g.test_framework :rspec
    end

    config.before_configuration do
      # If no config/predicate_mappings.yml file exists in the project this gem is pulled into, load predicates from the gem
      unless File.exists?('config/predicate_mappings.yml')
        require 'active-fedora'
        cul_hydra_models_gem_location = Bundler.rubygems.find_name('cul_hydra_models').first.full_gem_path
        config_path = File.join(cul_hydra_models_gem_location, 'config/predicate_mappings.yml')
        ActiveFedora.init(predicate_mappings_config_path: config_path)
      end
    end
  end
end
