import java.lang.Math.*;

Wormhole wormhole;
Blackhole[] blackholes = {new Blackhole(100, 40), new Blackhole(400, 500)};
Ship ship;
PGraphics backgroundGraphic;
int score = 0;
boolean gameover = false;

void setup(){
  size(600, 600);
  loadGraphics();
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
  setupStars();
  wormhole = new Wormhole();
  ship = new Ship();
}

void keyPressed(){
  ship.swapDirection();
}

/*
 * Generate a new background stored in the backgroundGraphic variable.
 */
void setupStars(){
  backgroundGraphic = createGraphics(width, height);

  backgroundGraphic.background(10);
  for(int i = 0; i < 100; i++){
    backgroundGraphic.beginDraw();
    backgroundGraphic.fill(#FFFFFF);
    backgroundGraphic.stroke(#FFFFFF);
    //Do we need to avoid stars being placed on the same pixel?
    //"You must use loops and arrays to get full marks for this part." - Do we really need arrays?
    backgroundGraphic.point(random(width), random(height));
    backgroundGraphic.endDraw();
  }
}

void graphics(){

  if(gameover){
    background(backgroundGraphic);
  }
  else{
    background(backgroundGraphic);

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
