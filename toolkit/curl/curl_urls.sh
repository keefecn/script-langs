#!/bin/bash
# batch get url header info

curl=`which curl`
awk=`which awk`
urls=$1

#for URL in `cat $urls`; do echo $URL; curl -m 10 -s -I $1 "$URL" | grep HTTP/1.1 |  awk {'print $2'}; done
echo -e '\nServer: --------------'
for URL in `cat $urls`; do echo $URL; curl -m 10 -s -I $1 "$URL" | grep Server: |  awk {'print $2'}; done

echo -e '\nCache: --------------'
for URL in `cat $urls`; do echo $URL; curl -m 10 -s -I $1 "$URL" | grep Cache-Control: |  awk {'print $0'}; done

