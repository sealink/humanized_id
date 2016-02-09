# coding: utf-8

# TODO: FIX THIS FILE UP
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'humanized_id/version'

Gem::Specification.new do |spec|
  spec.name          = 'humaized_id'
  spec.version       = HumanizedId::VERSION
  spec.authors       = ['Akil Madan']
  spec.email         = ['support@travellink.com.au']

  spec.summary       = 'Gem to convert an existing id to a human friendly id or ' \
                       'generate a new human friendly id based on a given charset'
  spec.description   = 'HumanizedId can be used to generate (or convert to) a ' \
                       'human friendly id based on a default (or passed in) charset'
  spec.homepage      = '' # TODO: Spec homepage
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'travis'
end
