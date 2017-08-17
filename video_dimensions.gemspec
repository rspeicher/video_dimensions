# -*- encoding: utf-8 -*-

require File.expand_path('../lib/video_dimensions/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "video_dimensions"
  gem.version       = VideoDimensions::VERSION
  gem.summary       = %q{Quick and easy video attributes}
  gem.description   = %q{Quick and easy video attributes -- width, height, bitrate, codec, duration, framerate.}
  gem.license       = "MIT"
  gem.authors       = ["Robert Speicher"]
  gem.email         = "rspeicher@gmail.com"
  gem.homepage      = "https://github.com/rspeicher/video_dimensions"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 3.2.0'
end
