'''
@filename: download.py
@author: Denny
@date: 2010-3-30 2011-5-16
@note:  -*- coding: utf-8 -*-
    eg: python download.py http://nonie.1ting.com:9092/zzzzzmp3/2011eMay/18E/18zhangliangying/01.wma 'zhan.wma'
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