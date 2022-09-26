import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

GPIO.setup(23, GPIO.IN)
GPIO.setup(24, GPIO.IN)

start_time = time.time()
seconds = 30
interval = 0.05
buffer = 0

while True:
    current_time = time.time()
    elapsed_time = current_time - start_time
    X = GPIO.input(23)
    Y = GPIO.input(24)

    if ((elapsed_time - buffer > interval) and (X < 0.5 or Y < 0.5)):
        print("X: ", X, ", Y: ", Y, ", Time: ", elapsed_time)
        buffer = elapsed_time

    if elapsed_time > seconds:
        break