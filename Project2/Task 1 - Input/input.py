import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)

GPIO.setup(22, GPIO.IN, pull_up_down=GPIO.PUD_DOWN)
GPIO.setup(23, GPIO.IN)
GPIO.setup(24, GPIO.IN)
GPIO.setup(25, GPIO.IN)

start_time = time.time()
seconds = 60
interval = 0.05
buffer = 0

while True:
    current_time = time.time()
    elapsed_time = current_time - start_time
    X = GPIO.input(23)
    Y = GPIO.input(24)
    Button = GPIO.input(22)
    Switch = GPIO.input(25)

    if ((elapsed_time - buffer > interval)):
        print("X: ", X, ", Y: ", Y, ", Button: ", Button, ", Switch: ", Switch, ", Time: ", elapsed_time)
        buffer = elapsed_time

    if elapsed_time > seconds:
        break