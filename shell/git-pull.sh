#! /bin/bash
#brief: git pull from remote
#file: git-pull.sh
#author: denny, wuqifu@gmail.com
#date: 2011-01-22

SUBDIRS=`ls -d */ | grep -v 'bin' | grep -v 'lib' | grep -v 'include'`
#SUBDIRS=gflags icethread icenetwork log4plus kittylog xmlcc scws

do_pull()
{
 for subdir in $SUBDIRS
 do
  ( cd $subdir && git pull && cd ..) 
 done
}

do_pull

