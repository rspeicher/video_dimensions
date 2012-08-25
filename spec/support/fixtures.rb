module Fixtures
  def fixture(path)
    File.expand_path(File.join('..', 'fixtures', path), File.dirname(__FILE__))
  end
end
