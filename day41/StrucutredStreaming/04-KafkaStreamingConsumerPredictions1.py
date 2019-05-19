# Create __SparkSession__ object

from pyspark.sql import SparkSession
import sys
# Import the necessary classes and create a local SparkSession, the starting point of all functionalities related to Spark.
from pyspark.sql.types import *
from pyspark.sql.functions import *
from pyspark.sql.functions import col,udf

from pyspark.ml import Pipeline, PipelineModel
from pyspark.ml.feature import  IDF
from pyspark.ml.feature import CountVectorizer
from pyspark.ml.feature import  Tokenizer
from pyspark.ml.feature import StringIndexer
from pyspark.ml.classification import RandomForestClassifier

spark = SparkSession \
    .builder \
    .appName("Kafka Spark Structured Streaming") \
    .config("spark.master", "local[*]") \
    .getOrCreate()

spark.sparkContext.setLogLevel("ERROR")

model = PipelineModel.load("file:///home/mahidharv/StructureStreamingKafka/Model")

print(model)

df = spark \
  .readStream \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "c.insofe.edu.in:9092") \
  .option("subscribe", "insofe_topic_batch47") \
  .option("startingOffsets", "earliest") \
  .load()

df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)")

df.printSchema()

df = df.select(col("value").cast("string"), col("timestamp"))
df = df.withColumn('message', split(df.value, "\t")[0])
df = df.select( "message", "timestamp")

df.printSchema()


test_predictions_lr = model.transform(df).select('message','rawprediction','prediction')


query = test_predictions_lr \
        .writeStream \
        .format("console") \
        .outputMode("append") \
        .option("truncate","false") \
        .start()

query.awaitTermination()
