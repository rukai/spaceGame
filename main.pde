import java.lang.Math.*;

Wormhole wormhole;
Blackhole[] blackholes = {new Blackhole(100, 40), new Blackhole(400, 500)};
Ship ship = new Ship();
Background theBackground = null;
int parallaxOffsetX = 0;
int parallaxOffsetY = 0;
int score = 0;
int highscore = 0;
boolean highscoreSet = false;
boolean gameover = false;
PImage backgroundGraphic = null;

//Constants to define the width and height of the game area (Not the window)
final int WIDTH = 600;
final int HEIGHT = 600;

void setup(){
  size(600, 630);
  loadGraphics();
  theBackground = new Background(); //background is already a method
  theBackground.start();
  newGame();
}

void draw(){
  if(gameover){
    renderGameover();
  }
  else{
    wormhole.act(); //Use templates to call all actors.
    ship.act();

    //move into ship code?
    if(ship.collision(wormhole)){
      newLevel();
      score++;
      if(score > highscore){
          highscore = score;
          highscoreSet = true;
      }
    }
    if(ship.collision(blackholes[0]) || ship.collision(blackholes[1])){
        gameover = true;
    }

    renderGame();
  }
}

/*
 * Reset variables for a new level to be played.
 */
void newLevel(){
  parallaxOffsetX = 0;
  parallaxOffsetY = 0;
  wormhole = new Wormhole();
  theBackground.setNewLocation();
}

/*
 * Reset variables for a new game to be played.
 */
void newGame(){
  gameover = false;
  score = 0;
  highscoreSet = false;
  ship = new Ship();

  newLevel();
}

void keyPressed(){

  if(gameover){
    //start a new game
    if(key == ' '){
      gameover = false;
      newGame();
    }
  }
  else{
    if(key == 'w'){
      parallaxOffsetY++;
    }
    else if(key == 's'){
      parallaxOffsetY--;
    }
    else if(key == 'a'){
      parallaxOffsetX--;
    }
    else if(key == 'd'){
      parallaxOffsetX++;
    }
    else{
      ship.swapDirection();
    }
  }
}

/*
 * Renders the graphics of the game
 */
void renderGame(){
  background(10);
  PImage bg = theBackground.getBackground();
  image(bg, parallaxOffsetX, parallaxOffsetY);

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
  //main HUD bar
  textSize(16);
  textAlign(LEFT);
  noStroke();
  fill(#822B66);
  int HUDY = height-30;
  rect(0, HUDY, width, height-1);

  //main
  fill(#611047);
  rect(4, HUDY + 4, 100, 22);
  rect(125, HUDY + 4, 145, 22);
  
  fill(#C382AE);
  text("Score: " + score, 10, HUDY+20);
  text("High Score: " + highscore, 130, HUDY+20);
}

/*
 * Renders the graphics of the game over screen
 */
void renderGameover(){
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(26);
  
  final int TEXTSPACING = 40;
  text("GAME OVER!", width/2, height/2-TEXTSPACING);
  if(highscoreSet){
    text("Congratulations, you set the new highscore.", width/2, height/2);
  }
  else{
    text("You got a score of: " + score, width/2, height/2);
  }
  text("The high score is: " + highscore, width/2, height/2+TEXTSPACING);
  text("Press spacebar to restart.", width/2, height/2+TEXTSPACING*2);
}
