require 'spec_helper'

describe VideoDimensions do
  describe "method" do
    it "instantiates a Backend object" do
      expect(VideoDimensions(fixture('720p.wmv'))).to be_kind_of(VideoDimensions::Backends::Base)
    end
  end

  describe "API" do
    context "class methods" do
      it { should respond_to(:dimensions) }
      it { should respond_to(:width) }
      it { should respond_to(:height) }
      it { should respond_to(:bitrate) }
      it { should respond_to(:codec) }
      it { should respond_to(:duration) }
    end
  end
end