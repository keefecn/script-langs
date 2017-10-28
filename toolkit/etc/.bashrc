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

# elasticsearch, 2017-2-7
#ulimit -n 65536
export JAVA_HOME=~/source/jdk1.8.0_121
export CLASSPATH=$CLASSPATH:$JAVA_HOME/lib:$JAVA_HOME/jre/lib

# hadoop, add by Denny, 2017-1-18
#HADOOP VARIABLES START
#export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-i386
export HADOOP_INSTALL=/usr/local/hadoop
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_INSTALL/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib"
export HADOOP_COMMON_HOME=$HADOOP_HOME
export HADOOP_HDFS_HOME=$HADOOP_HOME
export HADOOP_MAPRED_HOME=$HADOOP_HOME
export HADOOP_YARN_HOME=$HADOOP_HOME
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"

export PATH=$PATH:$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOOME/sbin:$HADOOP_HOME/lib
#HADOOP VARIABLES END

# NOTE: hbase 20181013. modified by Keefe
export HBASE_HOME=/home/hadoop/bin/hbase-1.3.0/
export PATH=$HBASE_HOME/bin:$PATH

# hive/spark/scala
# export HIVE_HOME=/usr/local/hadoop/hive
# export SCALA_HOME=/usr/local/hadoop/scala
# export SPARK_HOME=/usr/local/hadoop/spark

