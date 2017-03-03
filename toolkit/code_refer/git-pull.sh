#! /bin/bash
#brief: git pull from remote
#file: git-pull.sh
#author: denny, wuqifu@gmail.com
#date: 2011-01-22

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
