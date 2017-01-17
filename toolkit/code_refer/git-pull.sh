#! /bin/bash
#brief: git pull from remote
#file: git-pull.sh
#author: denny, wuqifu@gmail.com
#date: 2011-01-22

SUBDIRS=`ls -d */ | grep -v 'keefes'`
DIS_SUBDIRS='keefes bin'

do_pull()
{
  for subdir in $SUBDIRS
  do
    case subdir in
      $DIS_SUBDIRS)
  	continue
	;;
    esac

    echo ''
    echo '--'$subdir
    #( cd $subdir; git add *.md && git commit -m 'update readme' -a  && git push && git status)
    ( cd $subdir; git status && git pull )
  done
  echo ''
}

do_pull
echo 'git pull ok'
