require 'video_dimensions/backends/base'

module VideoDimensions
  module Backends
    autoload :FFmpeg,    'video_dimensions/backends/ffmpeg'
    autoload :MediaInfo, 'video_dimensions/backends/media_info'

    # Public: Returns the first available Backend class
    #
    # Examples
    #
    #   # `ffmpeg` binary is available
    #   Backends.first_available # => FFmpeg
    #
    #   # `ffmpeg` binary isn't available, but `mediainfo` is
    #   Backends.first_available # => MediaInfo
    #
    # Returns the class constant of the first available backend.
    def self.first_available
      available = constants.select { |c| const_get(c).available? }

      if available.length > 0
        const_get(available.first)
      else
        raise RuntimeError, "Could not find a compatible video attribute backend."
      end
    end
  end
end
