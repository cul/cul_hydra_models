module CulHydraModels
  class Engine < ::Rails::Engine
    isolate_namespace CulHydraModels

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
