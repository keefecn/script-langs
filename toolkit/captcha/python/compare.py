#! /usr/bin/python
# coding=utf-8
'''
@filename:
@brief: compare wordmode, use xor operation
@date: 2013-08-28
'''

import Image, os

mod = Image.open('0596.png')
target = Image.open('0596.png')
h = 8
w = 10
for y in range(h):
    for x in range(w):
        #im2.putpixel((x,y), im1.getpixel((x,y)) ^ im2.getpixel((x,y)))
        if mod[1].getpixel((xi, yi)) != target.getpixel((xi, yi)):
            diffs += 1
#im2.show()
