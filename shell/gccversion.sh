#!/bin/sh

gccver=`gcc --version | grep gcc | awk -F ' ' '{print $3}'`

if [ "${gccver}" \> "4.0.0" ]; then 
	echo $1
else 
	echo $2 
fi

exit 0