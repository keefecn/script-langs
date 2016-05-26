#!/usr/bin/python 
# -*- coding: utf-8 -*- 
''' 
@author: rex 
@blog: http://iregex.org 
@filename py_utf8_unicode.py 
@created: 2010-06-27 09:11 
@see: 详细出处参考：http://www.jb51.net/article/24386.htm
'''

import re 
def findPart(regex, text, name): 
    res=re.findall(regex, text) 
    if res: 
        print "There are %d %s parts:\n"% (len(res), name) 
        for r in res: 
            print '\t',r 
        print 

#sample is utf8 by default. 
sample='en: Regular expression is a powerful tool for manipulating text. \
zh: 正则表达式是一种很有用的处理文本的工具。 \
jp: 正規表現は非常に役に立つツールテキストを操作することです。 \
jp-char: あアいイうウえエおオ \
kr:정규 표현식은 매우 유용한 도구 텍스트를 조작하는 것입니다.'

#let's look its raw representation under the hood: 
##print "the raw utf8 string is:\n", repr(sample) 
##print 

#find the non-ascii chars: 
findPart(r"[\x80-\xff]+",sample,"non-ascii") 

#convert the utf8 to unicode 
usample=unicode(sample,'utf8') 

#let's look its raw representation under the hood: 
print "the raw unicode string is:\n", repr(usample) 
print 

#get each language parts: 
findPart(u"[\u4e00-\u9fa5]+", usample, "unicode chinese") 
findPart(u"[\uac00-\ud7ff]+", usample, "unicode korean") 
findPart(u"[\u30a0-\u30ff]+", usample, "unicode japanese katakana") 
findPart(u"[\u3040-\u309f]+", usample, "unicode japanese hiragana") 
findPart(u"[\u3000-\u303f\ufb00-\ufffd]+", usample, "unicode cjk Punctuation") 

