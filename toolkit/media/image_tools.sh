#!/bin/bash
#@requirement: imagemagick  
#  $ sudo apt-get install imagemagick 
#@tools: convert


# image format: jpg to png
for file in *.jpg; do convert $file ${file%%.}.png; done
# rename .jpg.png -> .png
rename .jpg.png .png *.jpg.png
