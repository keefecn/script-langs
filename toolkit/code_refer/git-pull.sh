#! /bin/bash
# ----------------------------------------------------------------------
# file: git-pull.sh
# author: keefe, wuqifu@gmail.com
# date: 2011-01-22, 2017/10/15
# note: git pull multiple projects from remote
# ----------------------------------------------------------------------

SUBDIRS=`ls -d */ | grep -v 'bin'`
#SUBDIRS='topicspider topicspider-design www'

do_pull()
{
    for subdir in $SUBDIRS
    do
        echo ''
        echo '--'$subdir
        #( cd $subdir; git status && git pull )
        cd $subdir;
        ret1=`git status`;
        ret11=`echo $ret1 | grep -E "ahead of|not staged"`;
        if [ -n "$ret11" ] ; then
            #echo $ret1;
            git status;
        fi
        git pull;
        cd ..
    done
    echo ''
}

do_pull
echo 'git pull ok'
