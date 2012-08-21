module VideoDimensions
  module Backends
    class FFmpeg < Base
      def self.available?
        `which #{binary} 2>&1 >> /dev/null`
        $?.exitstatus == 0
      end

      def self.binary
        'ffmpeg'
      end

      def initialize(input)
        @input = input
      end

      # Public: Video dimension
      #
      # Examples
      #
      #   >> FFmpeg.new('720p.wmv').dimensions
      #   => [1280, 720]
      #
      # Returns video dimensions as an array of width and height in pixels.
      def dimensions
        output.match(/Stream .+ Video: .+ \([\w\s]+\).* (\d+)x(\d+).*/) do |m|
          [m[1].to_i, m[2].to_i]
        end
      end

      # Public: Video width
      #
      # Returns video width in pixels
      def width
        dimensions && dimensions[0]
      end

      # Public: Video height
      #
      # Returns video height in pixels
      def height
        dimensions && dimensions[1]
      end

      # Public: Video bitrate
      #
      # Returns video bitrate in kbps
      def bitrate
        # Video streams don't always surface their own bitrate, so we'll settle
        # for the "total" bitrate
        output.match(/^\s+Duration: .+bitrate: (\d+) kb\/s$/m) do |m|
          m[1].to_i
        end
      end

      # Public: Video codec
      #
      # Examples
      #
      #   >> FFmpeg.new('720p.wmv').codec
      #   => "wmv3"
      #
      # Returns video codec ID
      def codec
        output.match(/Stream .+ Video: (.+) \([\w\s]+\)/m) do |m|
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
