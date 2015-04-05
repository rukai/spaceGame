public class Ship{
  float x = 300;
  float y = 300;
  float direction = 0;
  float increment = 1;
  float speed = 2; // 5 is default

  /*
   * All actions of the ship over a frame
   */
  public void act(){
    move();
    wrap();
  }

  /*
   * Moves the ship
   */
  private void move(){
    x += speed * cos(direction);
    y += speed * sin(direction);
    direction += increment * 0.03;
  }

  /*
   * Swaps the ships direction
   */
  public void swapDirection(){
    increment *= -1;
  }

  /*
   * Ship wraps around the window
   */
  private void wrap(){
    int shipW = shipGraphic.width;
    int shipH = shipGraphic.height;
    if(x < -shipW/2){
      x = width + shipW/2;
    }
    else if(x > width + shipW/2){
      x = 0 - shipW/2;
    }
    else if(y < -shipH/2){
      y = height + shipH/2;
    }
    else if(y > height + shipH/2){
      y = 0 - shipH/2;
    }
  }

  public float getDirection(){
    return direction;
  }

  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
}
