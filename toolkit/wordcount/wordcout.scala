#!/usr/bin/env spark-shell

# for spark
# hdfs url: hdfs://localhost:9000/user/denny/README.md

val textFile = sc.textFile("hdfs://...")
val counts = textFile.flatMap(line => line.split(" "))
                 .map(word => (word, 1))
                 .reduceByKey(_ + _)
counts.saveAsTextFile("hdfs://...")
