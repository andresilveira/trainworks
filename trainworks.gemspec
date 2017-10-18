# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trainworks/version'

Gem::Specification.new do |spec|
  spec.name          = 'trainworks'
  spec.version       = Trainworks::VERSION
  spec.authors       = ['André Herculano']
  spec.email         = ['andresilveirah@gmail.com']
  spec.homepage    = 'https://rubygems.org/gems/example'
  spec.summary       = 'Models a railroad as a graph and offers some traversing methods.'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec)/})
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.45.0'
  spec.add_development_dependency 'yard', '~> 0.9'
  spec.add_development_dependency 'redcarpet', '~> 3.3'
end
