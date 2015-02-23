# video_dimensions

Quick and easy video attributes -- width, height, bitrate, codec, duration, framerate.
Inspired by Sam Stephenson's [Dimensions](https://github.com/sstephenson/dimensions) gem.

## Features

Seamlessly supports multiple "backends" for sussing out video attributes, so it
will try to find whatever utility the system has available (see
[Supported Backends](#supported-backends)) and use that.

## Examples

```ruby
require 'video_dimensions'

VideoDimensions.dimensions('~/Movies/720p.wmv') # => [1280, 720]
VideoDimensions.width('~/Movies/720p.wmv')      # => 1280
VideoDimensions.height('~/Movies/720p.wmv')     # => 720
VideoDimensions.bitrate('~/Movies/720p.wmv')    # => 5904
VideoDimensions.codec('~/Movies/720p.wmv')      # => "WMV3"
VideoDimensions.duration('~/Movies/720p.wmv')   # => "00:00:02"
VideoDimensions.framerate('~/Movies/720p.wmv')  # => 21.83

v = VideoDimensions('~/Movies/720p.wmv')
v.dimensions # => [1280, 720]
v.width      # => 1280
v.height     # => 720
v.bitrate    # => 5904
v.codec      # => "WMV3"
v.duration   # => "00:00:02"
v.framerate  # => 21.83
```

## Requirements

One of the supported backends available in the system's `$PATH`.

### Supported Backends

* [FFmpeg](http://ffmpeg.org/) - `ffmpeg`
* [MediaInfo](http://mediainfo.sourceforge.net/en) - `mediainfo`

## Install

    $ gem install video_dimensions

## Version History

**0.3.1** (2015-02-23)

* Fix edge case in FFmpeg backend

**0.3.0** (2013-03-25)

* Add `framerate` attribute

**0.2.0** (2012-08-25)

* Add `duration` attribute

**0.1.1** (2012-08-21)

* Update FFmpeg backend patterns to match more video types

**0.1.0** (2012-08-20)

* Initial release.

## Copyright

Copyright (c) 2012-2015 Robert Speicher

See LICENSE.txt for details.
