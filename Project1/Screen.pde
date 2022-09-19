class Screen
{
  int w;
  int h;
  int x_pos;
  int y_pos;
  int order;
  
  Screen(int w_temp, int h_temp, int order_temp)
  {
    w = w_temp;
    h = h_temp;
    order = order_temp;
    x_pos = w * order;
    y_pos = 0;
  }
  
  void resize(int w_temp, int h_temp)
  {
    w = w_temp;
    h = h_temp;
    x_pos = w * order;
    y_pos = 0;
  }
  
  void updateOrder(int order_temp)
  {
    order = order_temp;
    x_pos = w * order;
  }
  
  int getWidth()
  {
    return w;
  }
  
  int getHeight()
  {
    return h;
  }
  
  int getXPos()
  {
    return x_pos;
  }
  
  int getYPos()
  {
    return y_pos;
  }
  
  int getOrder()
  {
    return order;
  }
}
