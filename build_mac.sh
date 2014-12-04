#!/bin/bash

# Requirements:
#
# I've built this on 10.9.5. I have no idea if this works in any
# other version of Mac OS X.
#
# You will need to have Xcode tools installed so you can generate
# the .icns file. (In general, it's a good thing to have installed
# if you're doing Mac dev.)
#
# Python modules you need to have installed beforehand:
# - setuptools  (may come with some versions of python?)
# - py2app
# - lxml        (requires libxml2, libxslt libs)
# - cython?
#
# Note that you want to use the system python, not one installed
# by macports or any other unix package system.
#
# I used macports to install the libxml2 and libxslt libraries.
#
# I highly recommend installing the python modules to your user
# directory, rather than polluting any of the global directories
# like /usr/local, /opt/local or /System.
#
# You will also need to install wxPython. This comes as a .dmg,
# but double-click to install doesn't work from the Finder in 10.9;
# you'll need to install it manually from the Terminal. See
# issue at: http://trac.wxwidgets.org/ticket/14523
#
# For reference, the version of wxPython I used was:
# - wxPython3.0-osx-3.0.1.1-cocoa-py2.7.dmg

# Generate the iconset:
mkdir Trelby.iconset
cp resources/icon16.png   Trelby.iconset/icon_16x16.png
cp resources/icon32.png   Trelby.iconset/icon_16x16@2x.png
cp resources/icon32.png   Trelby.iconset/icon_32x32.png
cp resources/icon64.png   Trelby.iconset/icon_32x32@2x.png
cp resources/icon128.png   Trelby.iconset/icon_128x128.png
cp resources/icon256.png   Trelby.iconset/icon_128x128@2x.png
cp resources/icon256.png   Trelby.iconset/icon_256x256.png
# todo: verify if these last three are necessary?
sips -z 512 512   resources/icon256.png --out Trelby.iconset/icon_256x256@2x.png
sips -z 512 512   resources/icon256.png --out Trelby.iconset/icon_512x512.png
sips -z 1024 1024 resources/icon256.png --out Trelby.iconset/icon_512x512@2x.png
iconutil -c icns Trelby.iconset
rm -R Trelby.iconset

# Duplicate the python file that loads trelby.
# This might look daft, but if we don't do this, py2app gets
# confused between bin/trelby and src/trelby.py, and most of
# the python modules in the src directory get ignored. We need
# to do this to avoid a broken .app:
cp bin/trelby bin/run_trelby.py

# Generate dist/Trelby.app:
python setup.py py2app

