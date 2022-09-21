# CPSC 334 - Project 1 - Generative Art

## Description
This program generates images of the Mandelbrot set. This program was specifically designed for Leed's studio in the CCAM - therefore, several views of the set can be generated and displayed at the same time. This allows for a separate view of the set to be displayed on each projector. It should be noted, however, that the number of views and the sections of the set that are displayed can be changed by the user. Moreover, the color scheme of the Mandelbrot set can be changed by the user within the Fractal class.

## Installation/Usage
1. Download the [Processing IDE](https://processing.org/download)
2. Download this [repo](https://github.com/Sgodilla/CPSC_334/tree/main/Project1)
3. Open GenerateFractals.pde in Processing
4. Set your screen resolution on line 20 (by default 1920x1080 pixels, CCAM projector resolution is 8160x768 pixels)
5. Run the application by pressing the debug button

## Customization
- The number of views to be displayed can be set on line 8 in GenerateFractals.pde
- The location of the set being viewed can be set by modifying the xVals, yVals, and RVals arrays. X and Y determine the coordinate position and R determines the range of the window.
- The color scheme can be changed by modifying the pallete array in the Fractal.pde class