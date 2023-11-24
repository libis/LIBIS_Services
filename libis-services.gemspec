# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'libis/services/version'

Gem::Specification.new do |spec|
  spec.name          = 'libis-services'
  spec.version       = Libis::Services::VERSION
  spec.authors       = ['Kris Dekeyser']
  spec.email         = ['kris.dekeyser@libis.be']
  spec.summary       = %q{LIBIS Services toolbox.}
  spec.description   = %q{Set of classes that simplify connection to different LIBIS services.}
  spec.homepage      = 'https://github.com/Kris-LIBIS/LIBIS_Services'
  spec.license       = 'MIT'

  spec.platform      = Gem::Platform::JAVA if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 10.3'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'simplecov', '~> 0.9'
  spec.add_development_dependency 'coveralls', '~> 0.7'
  spec.add_development_dependency 'equivalent-xml', '~> 0.6'
  spec.add_development_dependency 'rexml'

  spec.add_runtime_dependency 'libis-tools', '~> 1.1'
  spec.add_runtime_dependency 'highline', '~> 2.1'
  spec.add_runtime_dependency 'savon', '~> 2.14'
  spec.add_runtime_dependency 'rest-client', '~> 2.1'
  spec.add_runtime_dependency 'oai', '~> 1.2'
  spec.add_runtime_dependency 'ruby-oci8', '~> 2.2.12' unless RUBY_PLATFORM == 'java'
  spec.add_runtime_dependency 'virtus', '~> 2.0'
  # spec.add_runtime_dependency 'write_xlsx', '~> 0.83'
  spec.add_runtime_dependency 'awesome_print', '~> 1.9'
  spec.add_runtime_dependency 'httpclient', '~> 2.8'
end
