# CPSC 334 - Project 3 - Flight Simulator

## Description
This project showcases controlling a flight simulator with a gyroscope controller. Rather than using jostick or keyboard controls, one can treat the controller itself as if it were the aircraft. Pitching the controller up would pitch the aircraft up, rolling it to the left would roll the aircraft, etc. This allows for a far more intuitive flight control scheme. The flight simulator used in this project is Google Earth flight sim due to its easy to use control scheme, low compute resource usage, and large airport selection. 

## Installation/Usage
1. Download/clone this repo
2. Download [Google Earth Pro](https://www.google.com/earth/versions/#download-pro)
3. Turn on gyro controller
4. Run the command: python control.py
5. Open Google Earth Pro and enter into flight sim mode (press Ctrl+Alt+A)
6. Press both push buttons on gyro controller to start the simulation

## Controls
- Tilt the controller up and down to pitch the aircraft
- Rotate the controller clockwise and counter-clockwise to roll the aircraft
- The top push button increases speed and the bottom push button decreases speed
- Push both buttons simultaneously to start/stop the simulator 
- Tap the front touch sensor to bring up the aircraft's gears

## Wiring Diagram
![Wiring Diagram](https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F3b498905-44ca-43cd-aa52-283c9f7a1b0c%2FCS334_Diagrams_-_Gyro_Controller.png?table=block&id=2e210604-71a9-436a-a554-8add62f83ed6&spaceId=386a96bb-f4fe-40e0-87d0-68ee4e7a7a06&width=2000&userId=4a988110-3c61-442c-982f-eb6a2a1b2f4e&cache=v2)

## Demo Video
[![Flight Sim Demo]({https://www.notion.so/image/https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F12c9ca90-6f26-4d18-a355-ed67aaffe8de%2FFlight_Simulator_Usage.png?table=block&id=a148290c-ba13-4669-8c04-2427b3027bc5&spaceId=386a96bb-f4fe-40e0-87d0-68ee4e7a7a06&width=2000&userId=4a988110-3c61-442c-982f-eb6a2a1b2f4e&cache=v2})]({https://www.youtube.com/watch?v=XnnCsCA42xY} "Gyro Controlled Flight Sim Demo 1")