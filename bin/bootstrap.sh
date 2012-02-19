#!/bin/sh

mkdir -p .install
cd .install
rm -rf home-cooking
git clone git://github.com/joeyates/home-cooking.git
cd home-cooking
chef-solo -c chef-solo.rb -j attributes.js

