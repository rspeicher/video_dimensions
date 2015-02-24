require 'spec_helper'

module VideoDimensions::Backends
  describe FFmpeg do
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
        let(:sample) { FFmpeg.new(fixture('720p.wmv')) }

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
          expect(sample.bitrate).to eq 6503
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'wmv3'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:00:02'
        end

        it 'returns the correct framerate' do
          expect(sample.framerate).to eq 21.83
        end
      end

      context '1080p sample' do
        let(:sample) { FFmpeg.new(fixture('1080p.wmv')) }

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
          expect(sample.bitrate).to eq 9929
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'wmv3'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:00:02'
        end

        it 'returns the correct framerate' do
          expect(sample.framerate).to eq 21.83
        end
      end

      context 'Matroska sample', output_fixture: 'ffmpeg/matroska' do
        it 'returns the correct dimensions' do
          expect(sample.dimensions).to eq [1280, 720]
        end

        it 'returns the correct bitrate' do
          expect(sample.bitrate).to eq 3578
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'h264'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:47:10'
        end

        it 'returns the correct framerate' do
          expect(sample.framerate).to eq 23.98
        end
      end

      context 'H.264 sample', output_fixture: 'ffmpeg/h264' do
        it 'returns the correct dimensions' do
          expect(sample.dimensions).to eq [720, 404]
        end

        it 'returns the correct bitrate' do
          expect(sample.bitrate).to eq 1333
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'h264'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:21:08'
        end

        it 'returns the correct framerate' do
          expect(sample.framerate).to eq 23.98
        end
      end

      context 'XviD sample', output_fixture: 'ffmpeg/xvid' do
        it 'returns the correct dimensions' do
          expect(sample.dimensions).to eq [624, 352]
        end

        it 'returns the correct bitrate' do
          expect(sample.bitrate).to eq 1109
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'mpeg4'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:21:58'
        end

        it 'returns the correct framerate' do
          expect(sample.framerate).to eq 23.98
        end
      end

      context 'XviD sample 2', output_fixture: 'ffmpeg/xvid2' do
        it 'returns the correct dimensions' do
          expect(sample.dimensions).to eq [624, 352]
        end

        it 'returns the correct bitrate' do
          expect(sample.bitrate).to eq 949
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'mpeg4'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:51:33'
        end

        it 'returns the correct framerate' do
          expect(sample.framerate).to eq 23.98
        end
      end

      context '60 fps sample', output_fixture: 'ffmpeg/sixty_fps' do
        it 'returns the correct dimensions' do
          expect(sample.dimensions).to eq [1280, 720]
        end

        it 'returns the correct bitrate' do
          expect(sample.bitrate).to eq 9728
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'h264'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:10:14'
        end

        it 'returns the correct framerate' do
          expect(sample.framerate).to eq 60.00
        end
      end

      context 'invalid UTF-8 byte sequence sample', output_fixture: 'ffmpeg/invalid_utf8' do
        it 'returns the correct dimensions' do
          expect(sample.dimensions).to eq [720, 480]
        end

        it 'returns the correct bitrate' do
          expect(sample.bitrate).to eq 3589
        end

        it 'returns the correct codec' do
          expect(sample.codec).to eq 'h264'
        end

        it 'returns the correct duration' do
          expect(sample.duration).to eq '00:10:21'
        end

        it 'returns the correct framerate' do
          expect(sample.framerate).to eq 29.97
        end
      end
    end
  end
end
