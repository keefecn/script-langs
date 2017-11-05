#!/usr/bin/env pyspark

# for spark
# hdfs url: hdfs://localhost:9000/user/denny/README.md
text_file = sc.textFile("hdfs://...")
counts = text_file.flatMap(lambda line: line.split(" ")) \
             .map(lambda word: (word, 1)) \
             .reduceByKey(lambda a, b: a + b)
counts.saveAsTextFile("hdfs://...")
