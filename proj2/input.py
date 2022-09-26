import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

GPIO.setup(23, GPIO.IN)
GPIO.setup(24, GPIO.IN)

start_time = time.time()
seconds = 30

while True:
    current_time = time.time()
    elapsed_time = current_time - start_time
    
    print(GPIO.input(23), ", ", GPIO.input(24), ", ", elapsed_time)

    if elapsed_time > seconds:
        break