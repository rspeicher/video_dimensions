require 'spec_helper'

module VideoDimensions::Backends
  describe MediaInfo do
    describe ".available?" do
      it "returns true when utility is available" do
        described_class.expects(:system).with("which #{described_class::BINARY}").returns(true)
        described_class.should be_available
      end

      it "returns false when utility is not available" do
        described_class.expects(:system).with("which #{described_class::BINARY}").returns(false)
        described_class.should_not be_available
      end
    end

    describe "attribute methods" do
      subject { MediaInfo.new(fixture('720p.wmv')) }

      its(:dimensions) { should == [1280, 720] }
      its(:width)      { should == 1280 }
      its(:height)     { should == 720 }
      its(:bitrate)    { should == 5904 }
      its(:codec)      { should == "WMV3" }
    end
  end
end
