import time

import pika

def get_connection():
  try:
    return pika.BlockingConnection(pika.ConnectionParameters('192.168.1.10'))
  except pika.exceptions.AMQPConnectionError:
    print "Unable to connect to '192.168.1.10', trying to fall back on '192.168.1.11'" 
    return pika.BlockingConnection(pika.ConnectionParameters('192.168.1.11'))

def set_callback(connection):
  if connection:
    print " [!] Resetting connection because of error..."
    if connection.is_open: connection.close()
  connection = get_connection() 

  try:
    channel = connection.channel()
    channel.queue_declare(queue='hello')
    channel.basic_qos(prefetch_count=1)
    channel.basic_consume(callback,
                          queue='hello')

    print " [*] Waiting for messages. To exit press CTRL+C"
    channel.start_consuming()

  except pika.exceptions.ConnectionClosed:
    print " [!] Connection closed"
    set_callback(connection)

def callback(ch, method, properties, body):
  print " [x] Received %r" % (body,)
  time.sleep(4)
  print " [x] Done"
  ch.basic_ack(delivery_tag= method.delivery_tag)

set_callback(None)
