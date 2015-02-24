require 'spec_helper'

module VideoDimensions::Backends
  describe MediaInfo do
    describe '.available?' do
      it 'returns true when utility is available' do
        described_class.stubs(:binary).returns('whoami')
        expect(described_class).to be_available
      end

      it 'returns false when utility is not available' do
        described_class.stubs(:binary).returns('invalidbinary')
        expect(described_class).not_to be_available
      end
    end

    describe 'attribute methods' do
      context '720p sample' do
        let(:sample) { MediaInfo.new(fixture('720p.wmv')) }

        it 'returns the correct dimensions' do
          expect(sample.dimensions).to eq [1280, 720]
        end

        it 'returns the correct width' do
          expect(sample.width).to eq 1280
        end

        it 'returns the correct height' do
          expect(sample.height).to eq 720
        end

        it 'returns the correct bitrate' do
          expect(sample.bitrate).to eq 5904
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'WMV3'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:00:02'
        end

        # FIXME: MediaInfo mistakenly reports 1,000 fps?
        # it 'returns the correct framerate' do
        #   expect(sample.framerate).to eq 21.83
        # end
      end

      context '1080p sample' do
        let(:sample) { MediaInfo.new(fixture('1080p.wmv')) }

        it 'returns the correct dimensions' do
          expect(sample.dimensions).to eq [1440, 1080]
        end

        it 'returns the correct width' do
          expect(sample.width).to eq 1440
        end

        it 'returns the correct height' do
          expect(sample.height).to eq 1080
        end

        it 'returns the correct bitrate' do
          expect(sample.bitrate).to eq 9330
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'WMV3'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:00:02'
        end

        # FIXME: MediaInfo mistakenly reports 1,000 fps?
        # it 'returns the correct framerate' do
        #   expect(sample.framerate).to eq 21.83
        # end
      end

      context '60 fps sample', output_fixture: 'mediainfo/sixty_fps' do
        it 'returns the correct framerate' do
          expect(sample.framerate).to eq 60.00
        end
      end

      context 'duration of at least 1 hour', output_fixture: 'mediainfo/one_hour'  do
        it 'returns the correct duration' do
          expect(sample.duration).to eq '01:32:00'
        end
      end

      context 'duration of at least 1 minute', output_fixture: 'mediainfo/one_minute' do
        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:04:10'
        end
      end
    end
  end
end
