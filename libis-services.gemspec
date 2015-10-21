# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'libis/services/version'

Gem::Specification.new do |gem|
  gem.name          = 'libis-services'
  gem.version       = Libis::Services::VERSION
  gem.authors       = ['Kris Dekeyser']
  gem.email         = ['kris.dekeyser@libis.be']
  gem.summary       = %q{LIBIS Services toolbox.}
  gem.description   = %q{Set of classes that simplify connection to different LIBIS services.}
  gem.homepage      = 'https://github.com/Kris-LIBIS/LIBIS_Services'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.6'
  gem.add_development_dependency 'rake', '~> 10.3'
  gem.add_development_dependency 'rspec', '~> 3.1'
  gem.add_development_dependency 'simplecov', '~> 0.9'
  gem.add_development_dependency 'coveralls', '~> 0.7'
  gem.add_development_dependency 'equivalent-xml', '~> 0.6'

  gem.add_runtime_dependency 'libis-tools', '~> 0.9'
  gem.add_runtime_dependency 'iconv', '~> 1.0'
  gem.add_runtime_dependency 'highline', '~> 1.7'
  gem.add_runtime_dependency 'savon', '~> 2.11'
  gem.add_runtime_dependency 'rest-client', '~> 1.8'
  gem.add_runtime_dependency 'virtus', '~> 1.0'
  gem.add_runtime_dependency 'write_xlsx', '~> 0.83'
  gem.add_runtime_dependency 'awesome_print', '~> 1.6'
end
