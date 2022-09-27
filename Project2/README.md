# CPSC 334 - Project 2 - Interactive Devices

## Description
This project will allow one to use external control hardware (joystick, switches, buttons) with a Raspberry Pi. The program will print the input values of the Pi's GPIO pins.

## Installation / Usage
1. Install GPIO library with pip install RPi.GPIO
2. Connect a button to GPIO pin 22, joystick to GPIO pins 23 and 24, and switch to GPIO pin 25 on the Raspberry Pi
3. Start the program with python3 input.py, the program will only run for 60 seconds before terminating
