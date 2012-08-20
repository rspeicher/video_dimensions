require 'video_dimensions/backends'

# Returns a VideoDimensions instance for determining attributes for the
# provided video.
#
# input - Full path to video being processed
#
# Examples
#
#   v = VideoDimensions('~/Movies/720p.wmv')
#   v.dimensions # => [1280, 720]
#   v.width      # => 1280
#   v.height     # => 720
#   v.bitrate    # => 5904
#   v.codec      # => "WMV3"
#
# Returns a VideoDimensions::Backends object
def VideoDimensions(input)
  VideoDimensions::Backends.first_available.new(input)
end

module VideoDimensions

  # Public: Provides shortcuts to attribute methods
  #
  # Examples
  #
  #   VideoDimensions.dimensions('~/Movies/720p.wmv') # => [1280, 720]
  #   VideoDimensions.width('~/Movies/720p.wmv')      # => 1280
  #   VideoDimensions.height('~/Movies/720p.wmv')     # => 720
  #   VideoDimensions.bitrate('~/Movies/720p.wmv')    # => 5904
  #   VideoDimensions.codec('~/Movies/720p.wmv')      # => "WMV3"
  class << self
    def dimensions(input)
      process(:dimensions, input)
    end

    def width(input)
      process(:width, input)
    end

    def height(input)
      process(:height, input)
    end

    def bitrate(input)
      process(:bitrate, input)
    end

    def codec(input)
      process(:codec, input)
    end

    private

    def process(msg, input)
      Backends.first_available.new(input).send(msg)
    end
  end

end
