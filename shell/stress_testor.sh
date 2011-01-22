# /bin/bash
# method1:
#	for i in `seq 1 100000`; do [xxx]; done
# siege: siege - An HTTP/HTTPS stress tester
siege -c 300 http://news.51yuncai.com/serch_test.none
