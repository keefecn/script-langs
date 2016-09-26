# /bin/bash
# method 1: siege
#	for i in `seq 1 100000`; do [xxx]; done
# siege: siege - An HTTP/HTTPS stress tester
siege -c 300 http://192.168.115.142/zhenghe/searchdtest_http.php?key=qq
siege -c 100 -r 20 -f siege_urllist


# method 2: http stree testor, use curl
#! /bin/bash
# brief: calc time
#   method 1: /usr/bin/time $LINE 2>>$result
#   method 2: .$LINE 1>/dev/null 2>&1
#   method 4: curl $LINE 1>/dev/null 2>&1
result=run.log
startTime=`date '+%T_%F'` ;
if [ -a $result ]; then
result=${1}.${startTime}
fi;
echo "filename=$1" >$result
echo "start=$startTime" >>$result

# get cmd from file
FILENAME=$1
#exec 3<&0
exec 0< $FILENAME
while read LINE
do
    START=`date '+%s%N'`;
    COUNT=0;
    while [ $COUNT -lt 1 ]
    do
        curl $LINE 1>/dev/null 2>&1
        #curl $LINE
        COUNT=`expr $COUNT + 1`;
    done
    ret=$?

    END=`date '+%s%N'`;
    ELASP=$(( $((END-START)) / 1000000 )) ;
    echo "use time = $ELASP ms" >>$result
    
    if [ $ret == 0 ]; then
        echo "[ok] $ELASP ms $LINE"  >> $result
        echo "[ok] $ELASP ms $LINE" 
    else
        echo "[failed] $ELASP $LINE"  >> $result
        echo "[failed] $ELASP $LINE" 
    fi

    END=`date '+%s%N'`;
    ELASP=$(( $((END-START)) / 1000000 )) ;
    echo "use time = $ELASP ms" >>$result

done
#echo "use time = $END - $START = $(($END-$start)) ms" >>$result


#! /bin/bash
# file: batch.sh
# brief:  split -d -l [num] [filename]
prefix="x0";
prefix2="x";
for(( i=0; i<10; ++i ))
do
./enginetest.sh $prefix$i &
done;

for(( i=10; i<19; ++i ))
do
./enginetest.sh $prefix2$i &
done;