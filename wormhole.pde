class Wormhole extends Actor{
  private boolean expanding = true;
  final int MAX_DIAMETER = 80;

  public Wormhole(){
    x = random(MAX_DIAMETER/2, WIDTH - MAX_DIAMETER/2);
    y = random(MAX_DIAMETER/2, HEIGHT - MAX_DIAMETER/2);
    diameter = 0;
  }

  public void act(){
    //check for expanding/contracting
    if(diameter == 0){
      expanding = true;
    }
    else if(diameter == MAX_DIAMETER){
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
