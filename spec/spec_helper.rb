require 'rspec'
require 'rspec/its'
require 'video_dimensions'

Dir[File.expand_path("./spec/support/*.rb")].each { |f| require(f) }

RSpec.configure do |c|
  c.mock_with :mocha

  c.include Fixtures
end
