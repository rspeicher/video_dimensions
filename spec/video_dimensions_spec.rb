require 'spec_helper'

describe VideoDimensions do
  describe 'method' do
    it 'instantiates a Backend object' do
      expect(VideoDimensions(fixture('720p.wmv')))
        .to be_kind_of(VideoDimensions::Backends::Base)
    end
  end

  describe 'API' do
    context 'class methods' do
      %i(dimensions width height bitrate codec duration framerate).each do |m|
        it "responds to `#{m}`" do
          expect(described_class).to respond_to(m)
        end
      end
    end
  end
end
