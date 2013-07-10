# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sequel_tire/version'

Gem::Specification.new do |spec|
  spec.name = %q(sequel_tire)
  spec.version = SequelTire::VERSION
  spec.authors = ['Jason Ross']
  spec.email = %w(jasonr@databerry.com)
  spec.description = %q{Sequel plugin adapter for Tire ElasticSearch gem}
  spec.summary = %q{Sequel plugin adapter for Tire ElasticSearch gem}
  spec.homepage = ''
  spec.license = 'MIT'

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_dependency 'sequel'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'tire'
  spec.add_development_dependency 'fakeweb'
  spec.add_development_dependency 'sqlite3'
end
