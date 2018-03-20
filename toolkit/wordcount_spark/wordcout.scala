#!/usr/bin/env spark-shell

# for spark
# hdfs url: hdfs://localhost:9000/user/denny/README.md

val textFile = sc.textFile("hdfs://...")
val counts = textFile.flatMap(line => line.split(" "))
                 .map(word => (word, 1))
                 .reduceByKey(_ + _)
counts.saveAsTextFile("hdfs://...")

import org.apache.spark._
import SparkContext._
object WordCount {
  def main(args: Array[String]) {
    if (args.length != 3 ){
      println("usage is org.test.WordCount <master> <input> <output>")
      return
    }
    val sc = new SparkContext(args(0), "WordCount",
    System.getenv("SPARK_HOME"), Seq(System.getenv("SPARK_TEST_JAR")))
    val textFile = sc.textFile(args(1))
    val result = textFile.flatMap(line => line.split("\\s+"))
        .map(word => (word, 1)).reduceByKey(_ + _)
    result.saveAsTextFile(args(2))
  }
}
