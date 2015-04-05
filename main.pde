PImage shipGraphic;
PImage wormholeGraphic;
Wormhole wormhole;
Ship ship;

void setup(){
  size(600, 600);
  shipGraphic = loadImage("ship.bmp");
  //wormholeGraphic = loadImage("wormhole.png");
  
  setupArea();
}

void draw(){
  wormhole.act(); //Use templates to call all actors.
  ship.act();
  graphics();
}

void setupArea(){
  wormhole = new Wormhole();
  ship = new Ship();
}

void keyPressed(){
  ship.swapDirection();
}

void graphics(){
  background(10);

  //draw wormholes
  int d = wormhole.getDiameter();
  fill(255);
  ellipse(wormhole.getX(), wormhole.getY(), d, d);

  //draw ship
  //ellipse(x, y, 20, 20);
  translate(ship.getX(), ship.getY());
  rotate(ship.getDirection()+PI/2);
  imageMode(CENTER);
  image(shipGraphic, 0, 0);
}
