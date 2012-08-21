require 'spec_helper'

module VideoDimensions::Backends
  describe MediaInfo do
    describe ".available?" do
      it "returns true when utility is available" do
        described_class.stubs(:binary).returns('whoami')
        described_class.should be_available
      end

      it "returns false when utility is not available" do
        described_class.stubs(:binary).returns('invalidbinary')
        described_class.should_not be_available
      end
    end

    describe "attribute methods" do
      context "720p sample" do
        subject { MediaInfo.new(fixture('720p.wmv')) }

        its(:dimensions) { should == [1280, 720] }
        its(:width)      { should == 1280 }
        its(:height)     { should == 720 }
        its(:bitrate)    { should == 5904 }
        its(:codec)      { should == "WMV3" }
      end

      context "1080p sample" do
        subject { MediaInfo.new(fixture('1080p.wmv')) }

        its(:dimensions) { should == [1440, 1080] }
        its(:width)      { should == 1440 }
        its(:height)     { should == 1080 }
        its(:bitrate)    { should == 9330 }
        its(:codec)      { should == "WMV3" }
      end
    end
  end
end
