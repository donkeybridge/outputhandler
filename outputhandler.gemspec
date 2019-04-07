Gem::Specification.new do |s|
  s.name        = "outputhandler"
  s.version     = "0.1.2"
  s.date        = "2019-04-08"
  s.summary     = "Wrapper class that enables asynchronious output (pausing / unpausing)"
  s.description = "Wrapper class that enables asynchronious output (pausing / unpausing) "
  s.authors     = [ "Benjamin L. Tischendorf" ]
  s.email       = "github@jtown.eu"
  s.homepage    = "https://github.com/donkeybridge/outputhandler"
  s.platform    = Gem::Platform::RUBY
  s.license     = "BSD-4-Clause" 

  versioned = `git ls-files -z`.split("\0")

  s.files = Dir['{lib,features}/**/*',
                  'Rakefile', 'README*', 'LICENSE*',
                  'VERSION*', 'HISTORY*', '.gitignore'] & versioned
  # s.executables = (Dir['bin/**/*'] & versioned).map { |file| File.basename(file) }
  # s.test_files = Dir['spec/**/*'] & versioned
  s.require_paths = ['lib']

  # Dependencies
  # s.add_dependency 'bundler', '>= 1.1.16'
  s.add_development_dependency 'rspec','~>3.6'
  s.add_development_dependency 'cucumber','~>3.1'  
  s.add_development_dependency 'yard', '~>0.9'
end

