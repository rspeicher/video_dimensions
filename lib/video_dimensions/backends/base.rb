module VideoDimensions
  module Backends
    # Public: Base interface for Backends
    class Base
      def self.available?
        false
      end

      def dimensions
        raise NotImplementedError
      end

      def width
        raise NotImplementedError
      end

      def height
        raise NotImplementedError
      end

      def bitrate
        raise NotImplementedError
      end

      def codec
        raise NotImplementedError
      end

      def duration
        raise NotImplementedError
      end
    end
  end
end
