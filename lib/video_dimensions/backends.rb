module VideoDimensions
  module Backends
    autoload :MediaInfo, 'video_dimensions/backends/media_info'

    def self.first_available
      const_get(:MediaInfo)
    end

    # Public: Base class for Backends
    class Base
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
    end
  end
end
