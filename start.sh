#!/bin/bash
ulimit -c unlimited
procname="talkMidlayer"
curdir=`pwd`
$curdir/$procname --daemon=true --port=3220
pid=`pgrep $procname`
echo "$pid"

