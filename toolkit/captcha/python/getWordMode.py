#! /usr/bin/python
# coding=utf-8
'''
@filename: getWordMode.py
@brief: get wordmode, use crop
@date: 2013-08-28
'''

import Image, os

# define wordMode width/height/num/边距
w=9
h=10
letter_nums = 4
offset_x=24
offset_y=7

j = 1
#for f in os.listdir("."):
f="code/0.jpg"
#if f.endswith(".png"):
# L/RGB/CMTK
img = Image.open(f).convert("1")
for i in range(letter_nums):
    x = offset_x + i*(w+1);
    y = offset_y
    img.crop((x, y, x+w, y+h)).save("font/%d.bmp" % j)
    print "j=",j
    j += 1
