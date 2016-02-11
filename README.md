# ownGPS
An iOS app written in Swift to send your GPS Position to an own Map. Works over WiFi and (of course) Cellular.

## Requirements:

- AlamoFire v. 3.2.0
- Xcode 7.2
- iOS 8.0+

## Instructions:

- Put the PHP-files on a webserver (tested Apache 2.0 on Ubuntu 14.04)
- Open the Project in Xcode, build & sign it with your Developer ID and run it on your iOS device.
- Insert the server URL e.g. http://192.168.0.1/endpoint.php and press the blue button
- Statustext shows "Success!" and you can see your position on e.g. http://192.168.0.1/map.php

## License:

The MIT License (MIT)
Copyright (c) <2016>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
