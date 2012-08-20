require 'rspec'
require 'video_dimensions'

module Fixtures
  def fixture(path)
    File.expand_path(File.join('fixtures', path), File.dirname(__FILE__))
  end
end

RSpec.configure do |c|
  c.mock_with :mocha

  c.include Fixtures
end
