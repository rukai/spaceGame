import java.lang.Math.*;

Wormhole wormhole;
Blackhole[] blackholes = {new Blackhole(100, 40), new Blackhole(400, 500)};
Ship ship;
Background theBackground = null;
int score = 0;
int highscore = 0;
boolean highscoreSet = false;
boolean gameover = false;

void setup(){
  size(600, 600);
  loadGraphics();
  theBackground = new Background(); //background is already a method
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
  theBackground.newLocation();
  wormhole = new Wormhole();
  ship = new Ship();
}

/*
 * Reset variables for a new game to be played.
 */
void newGame(){
  newLevel();

  gameover = false;
  score = 0;
  highscoreSet = false;
}

void keyPressed(){
  ship.swapDirection();

  //start a new game
  if(gameover && key == ' '){
    gameover = false;
    newGame();
  }
}

/*
 * Renders the graphics of the game
 */
void renderGame(){
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
  textSize(16);
  textAlign(LEFT);
  fill(#20F020);
  rect(0, height-30, width, height-1);
  fill(0);
  text("Score: " + score, 10, height-10);
  text("High Score: " + highscore, 100, height-10);
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
