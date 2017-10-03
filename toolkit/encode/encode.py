# coding:GBK
'''
@version: $Id$
@author: Denny
@date: 2011-8-8
@note:  chinese code area
    Unicode: 2Byte (0x4E00-0x9FA5), python show: '\u????' <type unicdoe'>
    GBK: 2Byte (0x81 - 0xFE, 0x40 - 0xFE)
    GB2312: 2Byte (0xB0 - 0xF7, 0xA0 - 0xFE)
    UTF-8: 0080-xxxx
'''

import os
import sys
print 'start------'
print 'sys.stdout encode=', sys.stdout.encoding   # 会影响到print输出时的缺省编码
print 'system encode=', sys.getdefaultencoding()  #

# test1: '', u'', decode, encode, type
print 'test1------'
a = '徐若瑄'
b = u'徐若瑄'
print a, type(a)
print b, type(b)
print a.decode('gbk')
print a.decode('gbk').encode('utf-8')
# print a.decode('utf-8')   # cause error


'''
瑄-->
gb2312: error
GBK：AC75  --> '\xacu'
UniCode：U+x7444  (&#29764;) -->u'\u7444'
utf8:  --> '\xe7\x91\x84'
'''
# test2: unicode, encode
print 'test2------'
x = unicode("珍", "gbk")
print x, type(x)
x1 = x.encode('gbk')
x2 = x.encode('utf8')
print x1, type(x1)
print x2, type(x2)


# test3: www page charset
print 'test3------'
import urllib2
import re
# url="http://news.163.com/10/0222/05/603Q67SH00011229.html"
url = "http://www.chinanews.com/tw/2011/01-04/2763839.shtml"
page = urllib2.urlopen(url)
html = page.read()
#html = page.read().decode("gbk", 'ignore')
charsets = page.headers['Content-Type'].split(' charset=')
if len(charsets) > 1:
    #charset = page.headers.getparam('charset')
    charset = charsets[1].lower()
else:
    charsets = re.search(
        '<meta\s*http-equiv="?Content-Type"? content="text/html;\s*charset=([\w\d-]+?)"', html, re.IGNORECASE)
    charset = charsets.group(1)
print 'charset=', charset
