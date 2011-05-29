'''
@filename: download.py
@author: Denny
@date: 2011-5-29
@note:  download image or html
  -*- coding: utf-8 -*-
'''

from sgmllib import SGMLParser
import urllib, urllib2
import sys
import os

'''
@note: inherti from SGMLParser
@method: start_tag
'''
class URLListener(SGMLParser):
    def reset(self):                              
        SGMLParser.reset(self)
        self.urls = []
	self.imgs = []

    def start_a(self, attrs):
        href = [v for k, v in attrs if k=='href']
        if href:
		for url in href:
			# Note: url suffix
			suffix = url.split('.')[-1]
			if ( suffix == 'html' or suffix == 'htm' ): 
	   		 	self.urls.append(url)

    def start_img(self, attrs):
       src = [v for k, v in attrs if k=='src']
       if src:
            for url in src:
   	         # Note: url suffix
   	         #if (url.find('.jpg') >= 0):
		suffix = url.split('.')[-1]
		if ( suffix == 'jpg' or suffix == 'jpeg' ): 
   		 	self.imgs.append(url)


'''
@args urlseed: a listpage seed
@return list of url
'''
def getUrls(urlseed):
	usock=urllib2.urlopen(urlseed)
	parser=URLListener()
	parser.feed(usock.read())
	usock.close()
	parser.close()

	path = os.path.dirname(urlseed)
	for i in range(0,len(parser.urls)):
		# build path
		if parser.urls[i][0:4] != 'http':
			parser.urls[i] = path+'/'+parser.urls[i]
	return parser.urls

def getImageUrls(urlseed):
	usock=urllib2.urlopen(urlseed)
	parser=URLListener()
	parser.feed(usock.read())
	usock.close()
	parser.close()

	path = os.path.dirname(urlseed)
	for i in range(0,len(parser.urls)):
		# build path
		if parser.imgs[i][0:4] != 'http':
			parser.imgs[i] = path+'/'+parser.imgs[i]
	return parser.imgs

'''
@args urlist: list of url
@grgs filename: store file name
@return: 
'''
def downloadChannel_1(urllist, filename):
    # download url, store to one file
    fp = file(filename, 'a+')
    for url in urllist:
	print url
        f = urllib2.urlopen(url)
        htmlSource = f.read()
        fp.write(htmlSource)
        f.close()
    fp.close()

def downloadChannel(urllist):
    for url in urllist:
	print url
	# TODO: urlopen maybe error, need tolerate error
	try:
		f = urllib2.urlopen(url)
	except Exception,e:
		print url,e
		continue

	htmlSource = f.read()
	webpath = urllib2.url2pathname(url)
	filename = os.path.basename(webpath)
	fp = file(filename, 'wb')	
	fp.write(htmlSource)
	fp.close()
	f.close()

def downloadChannel_progress(urllist):
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

    for url in urllist:
	print url
	try:
		#get filename: image.split('/')[-1]
		#filehandler, m = urllib.urlretrieve(url, url.split('/')[-1], reporthook=reporthook)
		filehandler, m = urllib.urlretrieve(url, url.split('/')[-1])
	except Exception,e:
		print url,e

class downloadThread(Thread):
	def __init__(self, urllist)
		Thread.__init__(self)
		slef.urls = urllist
	def run(self):
	

def downloadChannel_multithread(urllist):
	def download(url):
		filename = url.split('/')[-1]
		fp = file(filename, 'wb')	
		htmlSource = urllib.urlopen(url).read()
		fp.write(htmlSource)
		fp.close()

	import threading
	task_threads = []
	count = 1
	for url in urllist:
		t = threading.Thread(target=download,args=(url,))
		count = count+1
		task_threads.append(t)

	for task in task_threads:
		task.start()	
	# wait thread end
	for task in task_threads:
		task.join()		


def is_img(url):
	global imglenth
	request=urllib2.Request(url)
	opener=urllib2.build_opener()
	try:
		con=opener.open(request)
		Type=con.headers.dict['content-type'][:5]  # judge head
		Length =int(con.headers.dict['content-length']) # judge image len
		if Length>imglenth:
			return Type
	except Exception,e:
		print url,e

	return 0;

def get_file_name(ospath,imgname):
	name = 'P'+str(random.randint(10000000,99999999))
	filepath = "%s%s.%s" % (ospath,name,(imgname.split('.'))[-1])
	return filepath  


'''
@args url: seedpage
@args dep: depth
@args ospath: local disk path
'''
def depth(url,dep,ospath):
	global num
	if dep<=0:
		return 0
	
	img=getImageUrls(url)
	for j in range(0,len(img)):
		if is_img(img[j]) == 'image':
			isExist = True;
			# judge file exist
			while(isExist): 
				filepath = get_file_name(ospath,img[j]);
				if (not os.path.exists(filepath)):
					isExist = False;
			try:
				urllib.urlretrieve(img[j], filepath)
				print 'down %d'%(num+1)
				num+=1
			except Exception,e:
				print img[j],e
		else:
			pass

	urls=getUrls(url)
	for url in urls:
		depth(url,dep-1,ospath)
	else:
		return 0
	return 1

if __name__ == '__main__':
	#imglenth = 1           
	#num=0
	#depth('http://www.tudou.com/',2, "E:\img\\")   

	#pagelist="http://www.bdwm.net/bbs/bbstcon.php?board=PKU_ShiJia&threadid=12550530"
	pagelist = sys.argv[1]
	urls = getUrls(pagelist)
	print 'urls size:', len(urls)
	#downloadChannel(urls)
	downloadChannel_multithread(urls)

