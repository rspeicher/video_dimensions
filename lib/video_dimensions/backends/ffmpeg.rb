module VideoDimensions
  module Backends
    class FFmpeg < Base
      def self.available?
        `which #{binary} 2>&1 > /dev/null`
        $?.exitstatus == 0
      end

      def self.binary
        'ffmpeg'
      end

      def initialize(input)
        @input = input
      end

      def dimensions
        output.match(/Stream .+ Video: .+ (\d+)x(\d+).*/) do |m|
          [m[1].to_i, m[2].to_i]
        end
      end

      def width
        dimensions && dimensions[0]
      end

      def height
        dimensions && dimensions[1]
      end

      def bitrate
        # Video streams don't always surface their own bitrate, so we'll settle
        # for the "total" bitrate
        output.match(/^\s+Duration: .+bitrate: (\d+) kb\/s$/m) do |m|
          m[1].to_i
        end
      end

      def codec
        output.match(/Stream .+ Video: (\w+)/m) do |m|
          m[1]
        end
      end

      def duration
        output.match(/Duration: ([\d\:]+)/) do |m|
          m[1]
        end
      end

      def framerate
        output.match(/([\d\.]+) tbr/) do |m|
          m[1].to_f
        end
      end

      private

      def ffmpeg_output
        `#{self.class.binary} -i "#{@input}" 2>&1`.strip
      end

      def output
        unless @output
          # Get raw output, then:
          # - Guard against invalid UTF-8 byte sequences
          # - Strip out the Audio codec section(s)
          @output = ffmpeg_output
            .encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
            .gsub(/.*(Input #0.*)output file must be specified.*/m, '\1')
        end

        @output
      end
    end
  end
end
