# -*- encoding: utf-8 -*-

require File.expand_path('../lib/video_dimensions/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "video_dimensions"
  gem.version       = VideoDimensions::VERSION
  gem.summary       = %q{Quick and easy video attributes}
  gem.description   = %q{Quick and easy video attributes -- width, height, bitrate, codec.}
  gem.license       = "MIT"
  gem.authors       = ["Robert Speicher"]
  gem.email         = "rspeicher@gmail.com"
  gem.homepage      = "https://github.com/tsigo/video_dimensions"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rake',    '~> 0.8'
  gem.add_development_dependency 'rspec',   '~> 2.4'
end
