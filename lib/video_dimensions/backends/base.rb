module VideoDimensions
  module Backends
    # Public: Base class for Backends
    class Base
      def self.available?
        false
      end

      # Public: Video dimension
      #
      # Returns video dimensions as an array of width and height
      #   in pixels.
      def dimensions
        raise NotImplementedError
      end

      # Public: Video width
      #
      # Returns video width in pixels
      def width
        raise NotImplementedError
      end

      # Public: Video height
      #
      # Returns video height in pixels
      def height
        raise NotImplementedError
      end

      # Public: Video bitrate
      #
      # Returns video bitrate in kbps
      def bitrate
        raise NotImplementedError
      end

      # Public: Video codec
      #
      # Returns video codec ID
      def codec
        raise NotImplementedError
      end

      # Public: Video duration
      #
      # Returns video duration as a string in hh:mm:ss format
      def duration
        raise NotImplementedError
      end
    end
  end
end
