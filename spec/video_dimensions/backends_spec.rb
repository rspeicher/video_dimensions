require 'spec_helper'

module VideoDimensions
  describe Backends do
    describe ".first_available" do
      it "returns the first available backend" do
        Backends::MediaInfo.stubs(:available?).returns(true)
        Backends.first_available.should == Backends::MediaInfo
      end
    end
  end
end
