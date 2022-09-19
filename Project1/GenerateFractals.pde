int w;
int h;
float xmin;
float xmax;
float ymin;
float ymax;
float zoomFactor = 1;
static int numScreens = 6;
int[] order = {0, 1, 2, 3, 4, 5}; // 2, 1, 0, 5, 4, 3
Screen[] screens;
Fractal[] fractals;
// Establish a range of values on the complex plane
// A different range will allow us to "zoom" in or out on the fractal
float[] xVals = {0, -0.722, -0.1600, -0.925, -0.745428,  -0.748}; // -0.722, -0.16
float[] yVals = {0,  0.246,  1.0405,  0.266,  0.113009,  0.100}; // 0.246, 1.0405
float[] RVals = {2,  0.019,  0.0260,  0.032,  0.000035,  0.0014}; // 0.019, 0.026

void setup()
{
  size(1920, 1080);
  noLoop();
  noStroke();
  background(255);
  
  w = width;
  h = height;
  print(w, " ", h, "\n");
  screens = new Screen[numScreens];
  fractals = new Fractal[numScreens];
  
  // Make sure we can write to the pixels[] array.
  // Only need to do this once since we don't do any other drawing.
  loadPixels();
  
  for (int i = 0; i < numScreens; i++)
  {
    screens[i] = new Screen(width / numScreens, height, order[i]);
    
    float x = xVals[i]; 
    float y = yVals[i];
    float R = RVals[i];
    xmin = x - R;
    xmax = x + R;
    ymin = y - R * (height / (width / numScreens));
    ymax = y + R * (height / (width / numScreens));
    
    fractals[i] = new Fractal(xmin, ymin, xmax, ymax, screens[i]);
    // Update Screen
    fractals[i].updateFractal();
  }
  
  updatePixels();
}

void draw(){}
