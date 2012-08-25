require 'video_dimensions/backends/base'

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
  end
end
