# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'geon'

Gem::Specification.new do |gem|
  gem.name          = 'geon'
  gem.author        = 'Alexander Suslov'
  gem.email         = ['a.s.suslov@gmail.com']
  gem.description   = %q{Geo data provider}
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/AlmazKo/geon'
  gem.files         = `git ls-files`.split($\)
  gem.test_files    = `git ls-files -- spec/*_spec.rb`.split($\)
  gem.require_paths = ['lib']
  gem.version       = Geon::VERSION
  gem.license       = 'MIT'
end
