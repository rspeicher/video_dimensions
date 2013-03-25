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
#   v.duration   # => "00:00:02"
#   v.framerate  # => 21.83
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
  #   VideoDimensions.duration('~/Movies/720p.wmv')   # => "00:00:02"
  #   VideoDimensions.framerate('~/Movies/720p.wmv')  # => 21.83
  class << self

    # Public: Video dimensions
    #
    # input - Path to video file
    #
    # Examples
    #
    #   VideoDimensions('720p.wmv').dimensions # => [1280, 720]
    #
    # Returns video dimensions as an array of width and height in pixels.
    def dimensions(input)
      process(:dimensions, input)
    end

    # Public: Video width
    #
    # input - Path to video file
    #
    # Examples
    #
    #   VideoDimensions('720p.wmv').width # => 1280
    #
    # Returns video width in pixels
    def width(input)
      process(:width, input)
    end

    # Public: Video height
    #
    # input - Path to video file
    #
    # Examples
    #
    #   VideoDimensions('720p.wmv').height # => 720
    #
    # Returns video height in pixels
    def height(input)
      process(:height, input)
    end

    # Public: Video bitrate
    #
    # input - Path to video file
    #
    # Examples
    #
    #   VideoDimensions('720p.wmv').bitrate # => 5904
    #
    # Returns video bitrate in kbps
    def bitrate(input)
      process(:bitrate, input)
    end

    # Public: Video codec
    #
    # input - Path to video file
    #
    # Examples
    #
    #   VideoDimensions('720p.wmv').codec # => "wmv3"
    #
    # Returns video codec ID
    def codec(input)
      process(:codec, input)
    end

    # Public: Video duration
    #
    # input - Path to video file
    #
    # Examples
    #
    #   VideoDimensions('720p.wmv').duration # => "00:00:02"
    #
    # Returns video duration as a string in hh:mm:ss format
    def duration(input)
      process(:duration, input)
    end

    # Public: Video framerate
    #
    # input - Path to video file
    #
    # Examples
    #
    #   VideoDimensions('720p.wmv').framerate # => 21.83
    #
    # Returns video framerate in frames per second as a float
    def framerate(input)
      process(:framerate, input)
    end

    private

    def process(msg, input)
      Backends.first_available.new(input).send(msg)
    end

  end

end
