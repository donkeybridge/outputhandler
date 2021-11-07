Gem::Specification.new do |s|
  s.name        = "outputhandler"
  s.version     = File.read("#{__dir__}/VERSION")
  s.date        = File.mtime("#{__dir__}/VERSION").strftime('%Y-%m-%d')
  s.summary     = "Wrapper class that enables asynchronious output (pausing / unpausing)"
  s.description = "Wrapper class that enables asynchronious output (pausing / unpausing) "
  s.authors     = [ "Benjamin L. Tischendorf" ]
  s.email       = "github@jtown.eu"
  s.homepage    = "https://github.com/donkeybridge/outputhandler"
  s.platform    = Gem::Platform::RUBY
  s.license     = "BSD-4-Clause" 
  s.required_ruby_version = '~> 2.7'

  versioned = `git ls-files -z`.split("\0")

  s.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  # s.add_dependency 'bundler', '>= 1.1.16'
  s.add_development_dependency 'rspec','~>3.6'
  s.add_development_dependency 'cucumber','~>3.1'  
  s.add_development_dependency 'yard', '~>0.9'
end

