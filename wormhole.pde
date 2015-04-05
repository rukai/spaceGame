class Wormhole{
  int x;
  int y;
  int diameter;
  boolean expanding = true;

  public Wormhole(){
    x = (int) random(width); //probs between zero and one
    y = (int) random(height);
    diameter = 0;
  }

  public void act(){
    //check for expanding/contracting
    if(diameter == 0){
      expanding = true;
    }
    else if(diameter == 80){
      expanding = false;
    }

    //Expand/contract
    if(expanding){
      diameter++;
    }
    else{
      diameter--;
    }
  }

  public int getX(){
    return x;
  }
  
  public int getY(){
    return y;
  }

  public int getDiameter(){
    return diameter;
  }

  public void warp(){
  }
}
