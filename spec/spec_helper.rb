require 'rspec'
require 'video_dimensions'

Dir[File.expand_path("./spec/support/*.rb")].each { |f| require(f) }

RSpec.configure do |c|
  c.mock_with :mocha
  c.expose_dsl_globally = true

  c.include Fixtures
end
