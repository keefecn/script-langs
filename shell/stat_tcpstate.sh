#@brief statics tcp connect state
#@author Denny
#! /bin/bash
netstat -n | awk '/^tcp/ {++S[$NF]} END {for(a in S) print a, S[a]}'
