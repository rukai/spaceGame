class Background extends Thread{
  float i = 0;
  color[] colors;
  PGraphics spiral;
  PGraphics stars;
  PGraphics background;
  PGraphics newSpiral;
  int spiralPower;
  float spiralPhase = 0; 
  int spiralDirection = 1; // a multiplier (-1 or 1) to change the direction of the spiral
  int phaseDirection = 1; // a multiplier (-1 or 1) to change the direction of the spiral's phase
  boolean backgroundRendered = false;
  boolean renderNewBackground = true;
  boolean[][] starArrangement;
  
  public Background(){
    colors = generateColors();
  }

  /*
   * Code to be run from another thread
   */
  public void run(){
    while(true){
      try{
        Thread.sleep(10);
      }
      catch(InterruptedException e){
      }
      if(renderNewBackground){
        newLocation();
        renderNewBackground = false;
      }
    }
  }

  /*
   * Generates a fresh background
   */
  private void newLocation(){
    newStarArrangement();
    stars = generateStars();

    if(newSpiral == null){
      newSpiral = generateSpiral(spiralPhase);
    }
    spiral = newSpiral;
    newSpiral = generateSpiral(spiralPhase);
    updateBackground();
  }

  /*
   * Generates the next frame of the background
   */
  private void updateBackground(){
    stars = generateStars();

    PGraphics tmpbg = createGraphics(width, height);
    tmpbg.beginDraw();
    tmpbg.image(spiral, 0, 0);
    tmpbg.image(stars, 0, 0);
    tmpbg.endDraw();
    background = tmpbg;
    backgroundRendered = true;
  }

  /*
   * Returns the next background frame (update stars)
   */
  public PImage getBackground(){
    try{
      while(!backgroundRendered){
        Thread.sleep(10);
      }
    }
    catch(InterruptedException e){
    }
    updateBackground();
    return background.get();
  }

  public void setNewLocation(){
    renderNewBackground = true;
  }

  /*
   * Returns an array of colors with a transition from dark blue to white
   */
  private int[] generateColors(){
    final int MAX_COLOR = 160;
    color[] colors = new color[20];
    for(int i = 0; i < colors.length; i++){
      int val = (i * MAX_COLOR / colors.length);
      int blueVal = i * 190 / 6;
      colors[i] = color(val+20, val+20, blueVal+50);
    }
    return colors;
  }

  /*
   * Returns a spiral on a black background
   */
  private PGraphics generateSpiral(float phase){
    //set rendering variables
    spiralPhase = random(PI*2);
    spiralDirection = (int(random(2)) == 0) ? 1 : -1;
    phaseDirection = (int(random(2)) == 0) ? 1 : -1;
    spiralPower = (int) random(70, 200);

    PGraphics spiral = createGraphics(width, height);
    spiral.beginDraw();
    spiral.background(10);

    for(int colorIndex = 0; colorIndex < colors.length; colorIndex++){
      for(float i = 0; i < 2000; i += 0.4){
        int colorsUsed = (int) Math.floor((colors.length * i / 2000));
        if(colorIndex > colorsUsed){
          continue;
        }
        int diameter = colorsUsed - colorIndex + 1;
        i *= spiralDirection;
        float xPixel = (i*cos((i+500)/spiralPower + phase))/5 + 300;
        float yPixel = (i*sin((i+500)/spiralPower + phase))/5 + 300;
        i *= spiralDirection;
        spiral.stroke(colors[colorIndex]);
        spiral.ellipse(xPixel, yPixel, diameter, diameter);
      }
    }
    spiral.endDraw();
    return spiral;
  }

  /*
   * Generates a new arrangement of stars and stores them in an array.
   */
  private void newStarArrangement(){
    starArrangement = new boolean[width][height];
    for(int i = 0; i < 100; i++){
      starArrangement[(int) random(width)][(int) random(height)] = true;
    }
  }

  /*
   * Generate next frame of star background
   */
  private PGraphics generateStars(){
    PGraphics backgroundGraphic = createGraphics(width, height);

    backgroundGraphic.beginDraw();
    for(int y = 0; y < starArrangement.length; y++){
      for(int x = 0; x < starArrangement[y].length; x++){
        if(starArrangement[y][x]){
          backgroundGraphic.colorMode(HSB, 100);
          backgroundGraphic.stroke(random(100), 50, 100, random(255));
          backgroundGraphic.point(x, y);
        }
      }
    }
    backgroundGraphic.endDraw();
    return backgroundGraphic;
  }
}
