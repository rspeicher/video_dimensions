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

      # Public: Video duration
      #
      # Returns video duration as a string in hh:mm:ss format
      def duration
        # MediaInfo only incudes the two longest durations in the ouptut (e.g.,
        # 1h 5m; 5m 10s; 10s 15ms)
        output.match(/^Duration\s+:( \d+h)?( \d+mn)?( \d+s)?(?: \d+ms)?$/) do |m|
          # Map all of the captures to Integers, removing the time notation and
          # converting nils to 0, and use sprintf to make include leading zeros
          sprintf("%02d:%02d:%02d", *m.captures.map(&:to_i))
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
