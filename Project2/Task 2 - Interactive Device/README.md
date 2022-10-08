# CPSC 334 - Project 2 - Task 2 - Joystick Synth

## Description
This code controls an ESP-32 to produce sin waves that drives a speaker. This generates synth tones on the speaker and the frequency of the tone is determined by joystick inputs. The joystick is split into 8 sectors like the notes in an octave. Pressing down on the joystick will shift the scale up an octave. 

## Installation / Usage
1. Build the synth circuit from this schematic
2. Download the Arduino IDE and install the ESP-32 dev kit
3. Download this code and open it in the Arduino IDE
4. Connect your ESP-32 to your computer and upload this code to the microcontroller
5. The synth should now be operational. Pushing the joystick in different directions will produce different tones. The potentiometer can change the volume level of the synth. Pressing down on the joystick will shift the pitch of the synth.