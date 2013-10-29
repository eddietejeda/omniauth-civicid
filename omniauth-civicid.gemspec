# coding: utf-8
require File.expand_path('../lib/omniauth/civic_id/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "omniauth-civicid"
  spec.version       = Omniauth::CivicID::VERSION
  spec.authors       = ["Oscar Rodriguez"]
  spec.email         = ["orodriguez@accela.com"]
  spec.description   = %q{An Omniauth strategy for CivicID}
  spec.summary       = %q{An Omniauth strategy for CivicID}
  spec.homepage      = "http://developer.accela.com/"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "omniauth", "~> 1.0"
  spec.add_dependency "oauth2", '~> 0.9.0'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.7"
end