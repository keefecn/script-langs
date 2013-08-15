#! /bin/bash
#@brief statics siege log of coucurrencies
#@author Denny

#replace file first
sed -i 's/,//g' $1
awk 'BEGIN{sum=0}{if($4>30)sum+=$9}END{print "concurrencies = " sum}' $1
