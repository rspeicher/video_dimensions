module Fixtures
  def fixture(path)
    File.expand_path(File.join('..', 'fixtures', path), File.dirname(__FILE__))
  end

  def output_fixture(path)
    File.read(fixture(path))
  end
end

# Hat tip to VCR
when_tagged_with_output_fixture = { output_fixture: lambda { |v| !!v } }

RSpec.configure do |config|
  config.before(:each, when_tagged_with_output_fixture) do |ex|
    ex.example_group.let(:sample) { described_class.new('') }

    sample.stubs(:output).returns(
      output_fixture(ex.metadata[:output_fixture] + ".txt")
    )
  end
end
