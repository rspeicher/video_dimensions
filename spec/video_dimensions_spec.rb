require 'spec_helper'

describe VideoDimensions do
  describe "API" do
    context "class methods" do
      it { should respond_to(:dimensions) }
      it { should respond_to(:width) }
      it { should respond_to(:height) }
      it { should respond_to(:bitrate) }
      it { should respond_to(:codec) }
    end
  end
end
