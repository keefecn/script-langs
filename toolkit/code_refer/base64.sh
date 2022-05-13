#!/bin/bash
#@requirement: base64, md5sum

# test string: hello
# base64 encode: base64('hello')=aGVsbG8K
echo 'hello' | base64

# base64 decode: 
echo 'aGVsbG8K' | base64 -d

# encode/decode file
echo 'hello' > 1.txt
base64 1.txt > 2.txt
base64 -d 2.txt

read -p 'wait to quit...'
rm *.txt


