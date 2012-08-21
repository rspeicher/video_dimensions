module VideoDimensions
  module Backends
    class MediaInfo < Base
      def self.available?
        `which #{binary} 2>&1 >> /dev/null`
        $?.exitstatus == 0
      end

      def self.binary
        'mediainfo'
      end

      def initialize(input)
        @input = input
      end

      # Public: Video dimension
      #
      # Examples
      #
      #   >> MediaInfo.new('720p.wmv').dimensions
      #   => [1280, 720]
      #
      # Returns video dimensions as an array of width and height
      #   in pixels.
      def dimensions
        [width, height] if width && height
      end

      # Public: Video width
      #
      # Returns video width in pixels
      def width
        output.match(/^Width\s+: ([\d\s]+) pixels$/) do |m|
          m[1].gsub(' ', '').to_i
        end
      end

      # Public: Video height
      #
      # Returns video height in pixels
      def height
        output.match(/^Height\s+: ([\d\s]+) pixels$/) do |m|
          m[1].gsub(' ', '').to_i
        end
      end

      # Public: Video bitrate
      #
      # Returns video bitrate in kbps
      def bitrate
        output.match(/^Bit rate\s+: ([\d\s]+) Kbps$/) do |m|
          m[1].gsub(' ', '').to_i
        end
      end

      # Public: Video codec
      #
      # Examples
      #
      #   >> MediaInfo.new('720p.wmv').codec
      #   => "WMV3"
      #
      # Returns video codec ID
      def codec
        output.match(/^Codec ID\s+: (.+)$/) do |m|
          m[1]
        end
      end

      private

      def output
        unless @output
          @output = `#{self.class.binary} "#{@input}"`

          # Strip out the Audio codec section(s)
          @output.gsub!(/(.*)^Audio( #\d+)?$.*/m, '\1')
        end

        @output
      end
    end
  end
end
