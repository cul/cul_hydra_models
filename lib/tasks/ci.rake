namespace :cul_hydra_models do

  begin
    # This code is in a begin/rescue block so that the Rakefile is usable
    # in an environment where RSpec is unavailable (i.e. production).

    require 'rspec/core/rake_task'

    RSpec::Core::RakeTask.new(:rspec) do |spec|
      spec.pattern = FileList['spec/**/*_spec.rb']
      spec.pattern += FileList['spec/*_spec.rb']
      spec.rspec_opts = ['--backtrace'] if ENV['CI']
    end

    RSpec::Core::RakeTask.new(:rcov) do |spec|
      spec.pattern = FileList['spec/**/*_spec.rb']
      spec.pattern += FileList['spec/*_spec.rb']
      spec.rcov = true
    end

    require 'rubocop/rake_task'

    desc 'Run style checker'
    RuboCop::RakeTask.new(:rubocop) do |task|
      task.requires << 'rubocop-rspec'
      task.fail_on_error = true
    end

  rescue LoadError => e
    puts "[Warning] Exception creating rspec rake tasks.  This message can be ignored in environments that intentionally do not pull in the RSpec gem (i.e. production)."
    puts e
  end

  desc "CI build without rubocop"
  task :ci_nocop do
    ENV['RAILS_ENV'] = 'test'
    Rails.env = ENV['RAILS_ENV']
    Rake::Task["cul_hydra_models:ci_task"].invoke
  end

  desc "CI build with Rubocop validation"
  task ci: ['cul_hydra_models:rubocop'] do
    ENV['RAILS_ENV'] = 'test'
    Rails.env = ENV['RAILS_ENV']
    Rake::Task["cul_hydra_models:ci_task"].invoke
  end

  desc "CI build"
  task :ci_task do
    require 'jettywrapper'
    Jettywrapper.url = "https://github.com/projecthydra/hydra-jetty/archive/7.x-stable.zip"
    Jettywrapper.jetty_dir = File.join(Rails.root, 'jetty') # This places the jetty directory inside of the dummy app

    unless File.exists?(Jettywrapper.jetty_dir)
      puts "\nNo test jetty found.  Will download / unzip a copy now.\n"
    end
    Rake::Task["app:jetty:clean"].invoke

    jetty_params = Jettywrapper.load_config.merge(jetty_home: Jettywrapper.jetty_dir)
    puts "Starting Fedora 3 (jettywrapper)...\n"
    error = Jettywrapper.wrap(jetty_params) do
      Rake::Task["cul_hydra_models:cmodel:reload_all"].invoke
      Rake::Task['cul_hydra_models:coverage'].invoke
      puts 'Stopping Fedora 3 (jettywrapper)...'
    end
    raise "test failures: #{error}" if error
  end

  desc "Execute specs with coverage"
  task :coverage do
    # Put spec opts in a file named .rspec in root
    ruby_engine = defined?(RUBY_ENGINE) ? RUBY_ENGINE : "ruby"
    ENV['COVERAGE'] = 'true' unless ruby_engine == 'jruby'
    Rake::Task["cul_hydra_models:rspec"].invoke
  end

end
