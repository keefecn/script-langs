#!/bin/bash
# ----------------------------------------------------------------------
# file: jump_dir.sh
# Env：windows 10，Git Bash
# run: source /e/jump_dir.sh superset
# author: keefe, wuqifu@gmail.com
# date: 2018/5/29
# ----------------------------------------------------------------------

CD_CMD=cd

# E:\dev\python\venv\superset-py27-env\Lib\site-packages
SUPERSET_HOME='/e/dev/python/venv/superset-py27-env/Lib/site-packages/'
GITHUB_HOME='/e/development/versionManager/git/github/'
OSCHINA_HOME='/e/development/versionManager/git/oschina/'
WORKSPACE_HOME='/e/workspaces/python.ws/'

function cd_mydir(){  
    $CD_CMD /e  
    if [ $1x = "superset"x ];  then      
        $CD_CMD $SUPERSET_HOME
    elif [ $1x = "github"x ];  then      
        $CD_CMD $GITHUB_HOME
    elif [ $1x = "oschina"x ];  then
      
        $CD_CMD $OSCHINA_HOME
    elif [ $1x = "workspace"x ];  then
      
        $CD_CMD $WORKSPACE_HOME 
    else  
        echo "error cmd"  
    fi  
}  
  
if [ $# -lt "1" ]; then
  echo usage: source $0 [dirname]
  # exit 1;
else 
  cd_mydir $1
fi