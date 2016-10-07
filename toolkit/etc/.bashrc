# .bashrc
# Set alias: ls, vi
alias ll='ls -l --color=auto'
alias vi='vim'

# export 
# runtime: find binary, liberary
export PATH=$PATH:~/app/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/app/lib
# compile: find liberary(=-L), include=(-I) 
export LIBRARY=$LIBRARY_PATH:~/app/lib
export C_INCLUDE_PATH=$C_INCLUDE_PATH:~/app/include
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:~/app/include
# locale:
export LC_ALL=zh_CN.UTF-8
