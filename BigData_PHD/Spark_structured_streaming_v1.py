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
from pyspark.ml.feature import StringIndexerModel
from itertools import chain


spark = SparkSession \
    .builder \
    .appName("Kafka Spark Structured Streaming") \
    .config("spark.master", "local[*]") \
    .getOrCreate()

spark.sparkContext.setLogLevel("ERROR")

model = PipelineModel.load("/user/2618B56/big_data_phd")

print(model)

df = spark \
  .readStream \
  .format("kafka") \
  .option("kafka.bootstrap.servers", "c.insofe.edu.in:9092") \
  .option("subscribe", "big_data_phd_2618B56") \
  .option("startingOffsets", "earliest") \
  .load()

df.selectExpr("CAST(key AS STRING)", "CAST(value AS STRING)")

df.printSchema()

df = df.select(col("value").cast("string"))
df = df.withColumn('News', df.value)
df = df.select( "News")

df.printSchema()

test_predictions_nb = model.transform(df).select('News','rawprediction','prediction')


# Get the index to actual label mapping
stringIndexerStage = [x for x in model.stages if isinstance(x, StringIndexerModel)][0]
actual_lables = stringIndexerStage.labels
index_lables = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0]
actual_index_label_mapping = dict(zip(index_lables, actual_lables))

mapping_expr = create_map([lit(x) for x in chain(*actual_index_label_mapping.items())])
pred_df_test = test_predictions_nb.withColumn('prediction_actual_name', mapping_expr[test_predictions_nb['prediction']])



query = pred_df_test \
        .writeStream \
        .format("json") \
        .option("checkpointLocation", "file:///home/2618B56/BigData_PHD/check") \
        .option("path", "file:///home/2618B56/BigData_PHD/ouput.json") \
        .outputMode("append") \
        .option("truncate","false") \
        .start()

query.awaitTermination()
