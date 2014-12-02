# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'libis/services/version'

Gem::Specification.new do |spec|
  spec.name          = 'LIBIS_Services'
  spec.version       = LIBIS::Services::VERSION
  spec.authors       = ['Kris Dekeyser']
  spec.email         = ['kris.dekeyser@libis.be']
  spec.summary       = %q{LIBIS Services toolbox.}
  spec.description   = %q{Set of classes that simplify connection to different LIBIS services.}
  spec.homepage      = 'https://github.com/Kris-LIBIS/LIBIS_Services'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_runtime_dependency 'LIBIS_Tools'
  spec.add_runtime_dependency 'iconv'
  spec.add_runtime_dependency 'highline'
  spec.add_runtime_dependency 'savon', '~> 2.0'
  spec.add_runtime_dependency 'rest_client'
  spec.add_runtime_dependency 'write_xlsx'
  spec.add_runtime_dependency 'awesome_print'
end
