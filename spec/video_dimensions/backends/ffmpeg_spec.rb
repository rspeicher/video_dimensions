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

      context 'Matroska sample' do
        let(:sample) { FFmpeg.new('') }

        before do
          # We don't want to store this particular file in Git as a fixture, so
          # just fake the output
          sample.stubs(:output).returns <<-EOF
              Metadata:
                creation_time   : 1970-01-01 00:00:00
              Duration: 00:47:10.78, start: 0.000000, bitrate: 3578 kb/s
                Stream #0:0: Audio: ac3, 48000 Hz, 5.1(side), s16, 384 kb/s (default)
                Stream #0:1(eng): Video: h264 (High), yuv420p, 1280x720, SAR 1:1 DAR 16:9, 23.98 fps, 23.98 tbr, 1k tbn, 47.95 tbc
          EOF
        end

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

      context 'MP4 sample' do
        let(:sample) { FFmpeg.new('') }

        before do
          sample.stubs(:output).returns <<-EOF
            Metadata:
              major_brand     : isom
              minor_version   : 512
              compatible_brands: isomiso2avc1mp41
              creation_time   : 1970-01-01 00:00:00
              encoder         : Lavf52.94.0
            Duration: 00:21:08.81, start: 0.000000, bitrate: 1333 kb/s
              Stream #0:0(und): Video: h264 (High) (avc1 / 0x31637661), yuv420p, 720x404 [SAR 1:1 DAR 180:101], 1200 kb/s, 23.98 fps, 23.98 tbr, 24k tbn, 47.95 tbc
              Metadata:
                creation_time   : 1970-01-01 00:00:00
                handler_name    : VideoHandler
              Stream #0:1(und): Audio: aac (mp4a / 0x6134706D), 48000 Hz, stereo, s16, 127 kb/s
              Metadata:
                creation_time   : 1970-01-01 00:00:00
                handler_name    : SoundHandler
          EOF
        end

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

      context 'XviD sample' do
        let(:sample) { FFmpeg.new('') }

        before do
          sample.stubs(:output).returns <<-EOF
            Metadata:
              encoder         : VirtualDubMod 1.5.10.2 (build 2540/release)
            Duration: 00:21:58.56, start: 0.000000, bitrate: 1109 kb/s
              Stream #0:0: Video: mpeg4 (Advanced Simple Profile) (XVID / 0x44495658), yuv420p, 624x352 [SAR 1:1 DAR 39:22], 23.98 tbr, 23.98 tbn, 23.98 tbc
              Stream #0:1: Audio: mp3 (U[0][0][0] / 0x0055), 48000 Hz, stereo, s16, 32 kb/s
          EOF
        end

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

      context 'XviD sample 2' do
        let(:sample) { FFmpeg.new('') }

        before do
          sample.stubs(:output).returns <<-EOF
            Metadata:
              encoder         : VirtualDubMod 1.4.13
            Duration: 00:51:33.55, start: 0.000000, bitrate: 949 kb/s
              Stream #0:0: Video: mpeg4 (XVID / 0x44495658), yuv420p, 624x352 [SAR 1:1 DAR 39:22], 23.98 tbr, 23.98 tbn, 23.98 tbc
              Stream #0:1: Audio: mp3 (U[0][0][0] / 0x0055), 48000 Hz, stereo, s16, 112 kb/s
          EOF
        end

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

      context '60 fps sample' do
        let(:sample) { FFmpeg.new('') }

        before do
          sample.stubs(:output).returns <<-EOF
            Metadata:
              creation_time   : 2010-09-02 07:01:52
            Duration: 00:10:14.61, start: 0.000000, bitrate: 9728 kb/s
              Stream #0:0(eng): Video: h264 (High), yuv420p, 1280x720 [SAR 1:1 DAR 16:9], 60 fps, 60 tbr, 1k tbn, 120 tbc (default)
              Stream #0:1(eng): Audio: aac, 48000 Hz, stereo, s16 (default)
          EOF
        end

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

      context 'invalid UTF-8 byte sequence sample' do
        let(:sample) { FFmpeg.new('') }

        before do
          sample.stubs(:ffmpeg_output).returns <<-EOF
            Input #0, mov,mp4,m4a,3gp,3g2,mj2, from 'foo.mov':
              Metadata:
                major_brand     : qt  
                minor_version   : 537199360
                compatible_brands: qt  
                creation_time   : 2014-11-30 18:01:59
              Duration: 00:10:21.32, start: 0.000000, bitrate: 3589 kb/s
                Stream #0:0(eng): Video: h264 (Main) (avc1 / 0x31637661), yuv420p(tv, smpte170m/smpte170m/bt709), 720x480, 2049 kb/s, SAR 40:33 DAR 20:11, 29.97 fps, 29.97 tbr, 30k tbn, 60k tbc (default)
                Metadata:
                  creation_time   : 2014-11-30 18:02:00
                  handler_name    : \xCE\xE1\xF0\xE0\xE1\xEE\xF2\xF7\xE8\xEA \xEF\xF1\xE5\xE2\xE4\xEE\xED\xE8\xEC\xEE\xE2 Apple
                  encoder         : H.264
                Stream #0:1(eng): Audio: pcm_s16be (twos / 0x736F7774), 48000 Hz, 2 channels, s16, 1536 kb/s (default)
                Metadata:
                  creation_time   : 2014-11-30 18:02:06
                  handler_name    : \xCE\xE1\xF0\xE0\xE1\xEE\xF2\xF7\xE8\xEA \xEF\xF1\xE5\xE2\xE4\xEE\xED\xE8\xEC\xEE\xE2 Apple
            At least one output file must be specified
          EOF
        end

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
