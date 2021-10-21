#! /bin/bash
# ----------------------------------------------------------------------
# file: git-pull.sh
# author: keefe, wuqifu@gmail.com
# date: 2011-01-22, 2017/10/15
# note: git pull multiple projects from remote
# ----------------------------------------------------------------------

DIR=*/
if [ $# -gt 0 ]; then
    DIR=$1/*/
fi
echo $#
echo "13."$DIR

SUBDIRS=`ls -d $DIR | grep -v 'bin'`
#SUBDIRS='topicspider topicspider-design www'

do_pull()
{
    for subdir in $SUBDIRS
    do
        echo ''
        echo '--'$subdir
        #( cd $subdir; git status && git pull & cd .. )
        cd $subdir;
        # check if changed from git status
        ret1=`git status`;
        ret11=`echo $ret1 | grep -E "ahead of|not staged"`;  #en
        ret12=`echo $ret1 | grep -E "变更"`;  #cn:gbk
        if [[ -n "$ret11" || $ret12 ]] ; then
            git status;
        fi
        git pull;
        cd ..
    done
    echo ''
}

do_pull
echo 'git pull ok'
