#!/bin/bash
#@requirement: imagemagick  
#  $ sudo apt-get install imagemagick 
#@tools: convert


# get file info
file [xx]

# image format: jpg to png
for file in *.jpg; do convert $file ${file%%.}.png; done


