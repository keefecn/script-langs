#!/bin/sh
# apt_install.sh: useful tools and doc.
#
# last updated: NOv 25,2007
# ----------------------------------------------------------------------
# This is a free shell script under GNU GPL version 2.0 or above
# Copyright (C) 2007 Denny
# ----------------------------------------------------------------------
APT="$(which apt-get)"
FLAG=" -y --force-yes"
#FLAG="-qq -y --force-yes"

#upgrade
#sudo $APT $FLAG upgrade
#develop tool
sudo $APT $FLAG install build-essential kernel-package 
sudo $APT $FLAG install g++ gcc make valgrind automake autoconf
sudo $APT $FLAG install sourcenav vim emacs flex bison nasm bouml
sudo $APT $FLAG install openssl ssh subversion rdiff
 
#applicate software
sudo $APT $FLAG install stardict 
sudo $APT $FLAG install vsftpd gftp
sudo $APT $FLAG install xmms xmms-singit gnomebaker d4x 
sudo $APT $FLAG install w32codecs gstreamer0.10-x realplay

#LAMP
sudo $APT $FLAG install mysql-server libmysqlclient15-dev apache2 php5 php5-mysql

#advance dev lib
sudo $APT $FLAG install zlib1g-dev libqt4-dev libxml2 libexpat1 gsoap 

#dev-doc
sudo $APT $FLAG install binutils-doc manpages-dev glibc-doc stl-manual libxml2-doc cpp-doc gcc-doc qt4-doc
sudo $APT $FLAG install php-doc perl-doc bison-doc flex-doc libwww-doc apache2-doc libstdc++6-4.3-doc autobook

#locale of zh-cn
sudo $APT $FLAG install openoffice.org-l10n-zh-cn debian-reference-zh-cn quick-reference-zh-cn 
sudo $APT $FLAG install language-support-zh 
sudo $APT $FLAG install fcitx scim-chinese scim-tables-zh yiyantang
#reader: pdf, chm, doc
sudo $APT $FLAG install gnochm
sudo $APT $FLAG install poppler-data xpdf-chinese-simplified 

#mozilla
sudo $APT $FLAG install mozilla-plugin-vlc mozilla-plugin-gnash mozilla-firefox-locale-zh-cn
#other
sudo $APT $FLAG install unrar wine

#source 
#cd ../download
#sudo $APT $FLAG -d source apache2-src 
#sudo $APT $FLAG -d source procps glibc-source
sudo $APT $FLAG install linux-source libncurses-dev


exit 0

## can't download
##gimp-help-zh-cn libstdc++6-doc 

##if Internal Error, Could not perform immediate configuration (2) on libc6
#cd /var/cache/apt/archives
##sudo dpkg -i --force-depends tzdata_2009n-0ubuntu0.8.10_all.deb libc6_2.8~20080505-0ubuntu9_i386.deb libc6-amd64_2.8~20080505-0ubuntu9_i386.deb findutils_4.4.0-2ubuntu3_i386.deb
#sudo apt-get -f install

#sudo dpkg -i --ignore-depends=libc6 libc6_....
