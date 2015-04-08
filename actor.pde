public abstract class Actor{
  protected float x = 0;
  protected float y = 0;
  protected int diameter = 0;

  public void act(){
  }

  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }

  public boolean collision(Actor actor){
    //add radius of both actors
    float combinedLength = diameter/2 + actor.getDiameter()/2;
    //distance between centers of both actors
    float distance = (float) Math.sqrt(Math.pow(x-actor.getX(), 2) + Math.pow(y-actor.getY(), 2));
    
    return combinedLength > distance;
  }

  public int getDiameter(){
    return diameter;
  }
}
