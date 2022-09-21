class Fractal
{
  int maxIterations = 1000;
  float xmin, xmax, ymin, ymax, dy, dx;
  color[] pallete = new color[maxIterations];
  Screen screen;
  
  
  Fractal(float tempXMin, float tempYMin, float tempXMax, float tempYMax, Screen tempScreen)
  {
    screen = tempScreen;
    
    // Start at negative half the width and height
    xmin = tempXMin;
    ymin = tempYMin;
    
    // x goes from xmin to xmax
    xmax = tempXMax;
    // y goes from ymin to ymax
    ymax = tempYMax;
    
    // Calculate amount we increment x,y for each pixel
    dx = (xmax - xmin) / (screen.w);
    dy = (ymax - ymin) / (screen.h);
    
    pallete[0] = color(0, 0, 0);
    for (int i = 1; i < maxIterations; i++)
    {
      float red = 255 * (cos((i/2) + PI) + 1) / 2;
      
      if (sin(i/2)>= 0)
        pallete[i] = color(red, 0, 0);
      else
        pallete[i] = color(red, red, red);
    }
  }
  
  void zoom(float tempXMin, float tempYMin, float tempXMax, float tempYMax)
  {
    
    // Start at negative half the width and height
    xmin = tempXMin;
    ymin = tempYMin;
    
    // x goes from xmin to xmax
    xmax = tempXMax;
    // y goes from ymin to ymax
    ymax = tempYMax;
    
    // Calculate amount we increment x,y for each pixel
    dx = (xmax - xmin) / (screen.w);
    dy = (ymax - ymin) / (screen.h);
  }
  
  void updateFractal()
  {
    // Start y
    float y0 = ymin;
    for (int j = 0; j < screen.h; j++) {
      // Start x
      float x0 = xmin;
      for (int i = 0; i < screen.w; i++) {
        float iteration = 0;
        float x = 0;
        float y = 0;
        
        while ((x*x + y*y <= (1 << 16)) && (iteration < maxIterations))
        {
          float xtemp = x*x - y*y + x0;
          y = 2*x*y + y0;
          x = xtemp;
          iteration = iteration + 1;
        }
        
        if (iteration < maxIterations)
        {
          float log_zn = log(x*x + y*y)/2;
          float nu = log(log_zn / log(2)) / log(2);
          iteration = iteration + 1 - nu;
        }
        
        color color1 = pallete[floor(iteration) % maxIterations];
        color color2 = pallete[(floor(iteration) + 1) % maxIterations];
        color color3 = lerpColor(color1, color2, iteration % 1);
        
        pixels[i+j*width + screen.w*screen.order] = color3;
        
        x0 += dx;
      }
      y0 += dy;
    }
  }
}
