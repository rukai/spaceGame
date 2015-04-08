public class Ship extends Actor{
  private float direction = 0;
  private float increment = 1;
  private float speed = 5; // 5 is default

  public Ship(){
    x = 300;
    y = 300;
    diameter = 25;
  }

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
}
