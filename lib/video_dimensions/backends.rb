module VideoDimensions
  module Backends
    autoload :MediaInfo, 'video_dimensions/backends/media_info'

    def self.first_available
      const_get(:MediaInfo)
    end
  end
end
