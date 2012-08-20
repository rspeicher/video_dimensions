# video_dimensions

Quick and easy video attributes -- width, height, bitrate, codec. Inspired by
[Dimensions](https://github.com/sstephenson/dimensions) by Sam Stephenson.

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

v = VideoDimensions('~/Movies/720p.wmv')
v.dimensions # => [1280, 720]
v.width      # => 1280
v.height     # => 720
v.bitrate    # => 5904
v.codec      # => "WMV3"
```

## Requirements

One of the supported backends available in the system's `$PATH`.

### Supported Backends

MediaInfo -- `mediainfo`

## Install

    $ gem install video_dimensions

## Version History

**0.1.0** (2012-08-20)

* Initial release.

## Copyright

Copyright (c) 2012 Robert Speicher

See LICENSE.txt for details.
