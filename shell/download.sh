#£¡/bin/bash

# curl-- transfer a URL
# SYNOPSIS: curl [options] [URL...]
# Options: -d/--data -O/--remote-name

# Eg1: emulate post method
postdata=" ";
host="http://192.168.0.225:81/Default.aspx";
curl -d $postdata $host

# Eg2: support multiple URLs. 
# like: http://any.org/archive1998/vol1/partb/filea.txt  [:N] --specify step counter for the ranges
curl -O http://any.org/archive[1996-1999]/vol[1-4]/part{a,b,c}/file[a-z:3].txt

# Eg3: download photo
curl -O  http://www.nengtong.net//uploads/allimg/110211/1-110211104[125-604].jpg
find . -size +20k -exec mv {} photo \;


# Wget - The non-interactive network downloader.
# SYNOPSIS: wget [option]... [URL]...
# Options: -r=--recursive -nc=--no-clobber -np=--no-parent -p -k=--convert-links

# Eg1: Retrieve the first two levels of wuarchive.wustl.edu, saving them to /tmp.
wget -r -l2 -P/tmp ftp://wuarchive.wustl.edu/

# Eg2: download specify directory
wget -r -p -k -np -nc -e robots=off http://www.example.com/mydir/

