#! /usr/bin/python
# coding=utf-8
'''
@filename: download.py
@author: Denny
@date: 2010-3-30 2011-5-16
@note:  
    usage: python download.py [url] [filename]
    Eg: python download.py  http://www.miit.gov.cn/n11293472/n11293832/n11293907/n11368223/n15668993.files/n15668841.pdf 'zhan.pdf'
'''

import urllib
import sys
def download(url, filename):
    def reporthook(block_count, block_size, file_size):
        # unget remote file size
        if file_size == -1:
            print "download", block_count*block_size, 'Byte'
        # show download progress in realtime
        else:
            percentage = int((block_count*block_size*100) / file_size)
            if percentage > 100:
                print '100%'
            else:
                print 'progress %d%%' % (percentage)

    filehandler, m = \
                urllib.urlretrieve(url, filename, reporthook=reporthook)
    print 'download finish'

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print 'usage: %s url filename' % sys.argv[0]
    else:
        download(sys.argv[1], sys.argv[2])