from kafka import KafkaProducer
from kafka.errors import KafkaError
import os
import sys


# configure multiple retries
producer = KafkaProducer(bootstrap_servers=['c.insofe.edu.in:9092'], retries=5)

def on_send_success(record_metadata):
    print(record_metadata.topic)
    print(record_metadata.partition)
    print(record_metadata.offset)
    print("Message sent successfully")

def on_send_error(excp):
    log.error('Error:', exc_info=excp)

dirPath = "/home/datasets/PHD_Dataset/Test"
file_list = [os.path.join(dirPath, file) for file in os.listdir(dirPath)]
#fileText = open(filename, "r")

for file in file_list:
    # Note that the application is responsible for encoding messages to type str
    fileText = open(file, "r")
    producer.send("big_data_phd_2618B56", fileText.read()).add_callback(on_send_success).add_errback(on_send_error)

# block until all async messages are sent
producer.flush()
