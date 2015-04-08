import java.lang.Math.*;

Wormhole wormhole;
Blackhole[] blackholes = {new Blackhole(100, 40), new Blackhole(400, 500)};
Ship ship;
Background theBackground = null;
int score = 0;
boolean gameover = false;

void setup(){
  size(600, 600);
  loadGraphics();
  theBackground = new Background(); //background is already a method
  setupArea();
}

void draw(){
  wormhole.act(); //Use templates to call all actors.
  ship.act();

  //move into ship code?
  if(ship.collision(wormhole)){
    setupArea();
    score++;
  }
  if(ship.collision(blackholes[0]) || ship.collision(blackholes[1])){
      gameover = true;
  }

  graphics();
}

void setupArea(){
  theBackground.newLocation();
  wormhole = new Wormhole();
  ship = new Ship();
}

void keyPressed(){
  ship.swapDirection();
}


void graphics(){

  if(gameover){
    background(theBackground.getBackground());
  }
  else{
    background(theBackground.getBackground());

    //draw wormholes
    int d = wormhole.getDiameter();
    fill(255);
    ellipse(wormhole.getX(), wormhole.getY(), d, d);

    //draw ship
    //ellipse(ship.getX(), ship.getY(), 20, 20);
    PGraphics shipBuffer = createGraphics(width, height);
    shipBuffer.beginDraw();
    shipBuffer.translate(ship.getX(), ship.getY());
    shipBuffer.rotate(ship.getDirection()+PI/2);
    shipBuffer.imageMode(CENTER);
    shipBuffer.image(shipGraphic, 0, 0);
    shipBuffer.endDraw();
    image(shipBuffer, 0, 0);

    //draw blackholes
    stroke(255);
    fill(0);
    for(int i = 0; i < blackholes.length; i++){
      d = blackholes[i].getDiameter();
      ellipse(blackholes[i].getX(), blackholes[i].getY(), d, d);
    }

    //draw score
    fill(255);
    text("Score: " + score, 10, height-10);
  }
}
