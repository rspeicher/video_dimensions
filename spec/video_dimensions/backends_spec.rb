require 'spec_helper'

module VideoDimensions
  describe Backends do
    describe ".first_available" do
      it "returns the first available backend" do
        Backends::MediaInfo.stubs(:available?).returns(true)
        Backends::FFmpeg.stubs(:available?).returns(false)
        expect(Backends.first_available).to eq Backends::MediaInfo

        Backends::MediaInfo.stubs(:available?).returns(false)
        Backends::FFmpeg.stubs(:available?).returns(true)
        expect(Backends.first_available).to eq Backends::FFmpeg
      end

      it "raises exception when none are available" do
        Backends::FFmpeg.stubs(:available?).returns(false)
        Backends::MediaInfo.stubs(:available?).returns(false)

        expect { Backends.first_available }.to raise_error(RuntimeError, /compatible video attribute backend/)
      end
    end
  end
end
