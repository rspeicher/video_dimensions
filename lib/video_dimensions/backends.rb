module VideoDimensions
  module Backends
    autoload :FFmpeg,    'video_dimensions/backends/ffmpeg'
    autoload :MediaInfo, 'video_dimensions/backends/media_info'

    def self.first_available
      available = constants.select { |c| const_get(c).available? }

      if available.length > 0
        const_get(available.first)
      else
        raise RuntimeError, "Could not find a compatible video attribute backend."
      end
    end

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
    end
  end
end
