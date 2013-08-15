#! /bin/bash
filename=$1
sed -i '/^$/d' $filename

# method2: vim
# %s/^n//g
