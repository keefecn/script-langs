#! /usr/bin/python
# coding=utf-8
'''
@filename:
@brief:
@date: 2013-08-28
@refer: http://513394217.blog.163.com/blog/static/1097911862012552239277/
'''

import os, Image

# 二值化
def binary(f):
    img = Image.open(f)
    #img = img.convert('1')
    pixdata = img.load()
    for y in xrange(img.size[1]):
        for x in xrange(img.size[0]):
            if pixdata[x, y][0] < 90:
                pixdata[x, y] = (0, 0, 0, 255)
    for y in xrange(img.size[1]):
        for x in xrange(img.size[0]):
            if pixdata[x, y][1] < 136:
                pixdata[x, y] = (0, 0, 0, 255)
    for y in xrange(img.size[1]):
        for x in xrange(img.size[0]):
            if pixdata[x, y][2] > 0:
                pixdata[x, y] = (255, 255, 255, 255)
    return img

# 切割
def division(img):
    font=[]
    for i in range(4):
        x=7+i*13
        y=3
        font.append(img.crop((x,y,x+9,y+13)))
    return font

# load font modules  (char, image)
fontMods = []
for i in range(10):
    fontMods.append((str(i), Image.open("./font/%0d.png" %i)))
for i in range(26):
    c = chr(ord('A') + i)
    fontMods.append((c, Image.open("./font/%s.bmp" % c)))

def recognize(f):
    im = Image.open(f)
    im2 = im.convert('1')
    # check 5 fonts
    result = "./result/"
    for i in range(5):
        x = 10 + i*18
        y = 6
        target = im.crop((x, y, x+8, y+10))
        points = []
        # compare diffs
        for mod in fontMods:
            diffs = 0
            for yi in range(10):
                for xi in range(8):
                    if mod[1].getpixel((xi, yi)) != target.getpixel((xi, yi)):
                        diffs += 1
            points.append((diffs, mod[0]))
        points.sort()
        result += points[0][1]
    result += ".png"
    print "save to", result
    im.save(result);

if __name__ == '__main__':
    codedir="./code/"
    for imgfile in os.listdir("."):
        if imgfile.endswith(".png"):
            resdir="./result/"
            img=binary(codedir+imgfile)
            num=recognize(img)
            resdir += (num+".png")
            print "save to", resdir
            img.save(resdir)
            #recognize(imgfile)
