import datetime

import pika

def get_connection():
  try:
    return pika.BlockingConnection(pika.ConnectionParameters('192.168.1.10'))
  except pika.exceptions.AMQPConnectionError:
    print "Unable to connect to '192.168.1.10', trying to fall back on '192.168.1.11'" 
    return pika.BlockingConnection(pika.ConnectionParameters('192.168.1.11'))

connection = get_connection()
channel = connection.channel()
channel.queue_declare(queue='hello')

message = 'message sent at ' + str(datetime.datetime.now())

channel.basic_publish(exchange='',
                      routing_key='hello',
                      body=message)

print " [X] Sent %r" % (message,)

connection.close()
