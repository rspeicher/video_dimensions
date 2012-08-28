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

      private

      def output
        unless @output
          @output = `#{self.class.binary} -i "#{@input}" 2>&1`.strip

          # Strip out the Audio codec section(s)
          @output.gsub!(/.*(Input #0.*)output file must be specified.*/m, '\1')
        end

        @output
      end
    end
  end
end
