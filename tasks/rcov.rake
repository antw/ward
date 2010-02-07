begin
  require 'rcov'
  require 'spec/rake/spectask'
  require 'spec/rake/verify_rcov'

  Spec::Rake::SpecTask.new(:rcov) do |rcov|
    rcov.pattern    = 'spec/**/*_spec.rb'
    rcov.libs      << 'lib' << 'spec'
    rcov.spec_opts << '--options' << 'spec/spec.opts'
    rcov.rcov      = true
    rcov.rcov_opts = File.read('spec/rcov.opts').split(/\s+/)
  end

  RCov::VerifyTask.new('rcov:verify' => :rcov) do |rcov|
    rcov.threshold = 100
  end
rescue LoadError
  %w(rcov rcov:verify).each do |name|
    task name do
      abort "rcov is not available. In order to run #{name}, you must: gem " \
            "install rcov"
    end
  end
end
