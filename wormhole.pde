class Wormhole extends Actor{
  private boolean expanding = true;

  public Wormhole(){
    x = random(width);
    y = random(height);
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

  public void warp(){
  }
}
