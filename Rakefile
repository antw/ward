require 'rake'
require 'rake/clean'

require File.expand_path('../lib/ward/version', __FILE__)

CLOBBER.include ['pkg', '*.gem', 'doc', 'coverage', 'measurements']

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'ward'
    gem.summary     = 'Ward'
    gem.homepage    = 'http://github.com/antw/ward'
    gem.description = 'Object validation inspired by RSpec.'

    gem.author      = 'Anthony Williams'
    gem.email       = 'hi@antw.me'

    gem.platform    = Gem::Platform::RUBY
    gem.has_rdoc    = false

    # Dependencies.
    gem.add_dependency 'activesupport', '>= 3.0.0.beta'

    # Development dependencies.
    gem.add_development_dependency 'rspec',     '>= 1.3.0'
    gem.add_development_dependency 'cucumber',  '>= 0.3'
    gem.add_development_dependency 'yard',      '>= 0.5'

    gem.post_install_message =
      "************************************************************\n" \
      "\n" \
      "Thank you for installing ward-#{Ward::VERSION}\n" \
      "\n" \
      "Please note that 0.1 is a preview release and considered\n" \
      "unsuitable for use in a production environment.\n" \
      "\n" \
      "************************************************************\n" \
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem ' \
       'install jeweler'
end

FileList['tasks/**/*.rake'].each { |task| import task }
