#!/bin/bash

# mp3 tag: encoding convert
sudo apt-get install python-mutagen

# mp3 tag: ID3v1, ID3v2 2.3, ID3v2 2.4, APEv2
# setup mp3 tag encoding is gbk
mid3iconv -e gbk *.mp3 --remove-v1
