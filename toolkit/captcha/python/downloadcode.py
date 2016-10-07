#! /usr/bin/python
# coding=utf-8
'''
@filename: downloadcode.php
@brief: get different code from remote
@date: 2013-08-28
'''

import urllib, random
for i in range(3):
    #url = 'http://su.100steps.net/2007/vote/verify.php'
    url = 'http://localhost/captcha/generate/checkcode.php'
    print "download", i
    #imgName = "./code/%04d.png" %random.randrange(10000)
    imgName = "./code/%d.jpg" %i
    file(imgName, "wb").write(urllib.urlopen(url).read())
