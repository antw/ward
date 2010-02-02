require 'rake'
require 'rake/clean'

CLOBBER.include ['pkg', '*.gem', 'doc', 'coverage', 'measurements']

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name        = 'luggage'
    gem.summary     = 'Luggage'
    gem.homepage    = 'http://github.com/antw/luggage'
    gem.description = 'Half suitcase, half homicidal maniac: '\
                      'Object validation inspired by RSpec'

    gem.author      = 'Anthony Williams'
    gem.email       = 'hi@antw.me'

    gem.platform    = Gem::Platform::RUBY
    gem.has_rdoc    = false

    # Dependencies.
    gem.add_dependency 'active_support', '>= 3.0.pre'

    # Development dependencies.
    gem.add_development_dependency 'rspec',     '>= 1.3.0'
    gem.add_development_dependency 'cucumber',  '>= 0.3'
    gem.add_development_dependency 'yard',      '>= 0.5'
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem ' \
       'install jeweler'
end

FileList['tasks/**/*.rake'].each { |task| import task }
